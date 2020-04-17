//
//  Router+Execute.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/17.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

// MARK: - Do

public extension RaRouter {
    
    /// Execute router by `Module.Table`.
    ///
    /// - Parameters:
    ///   - table: Router to be executed.
    ///   - param: Parameters required for this router.
    /// - Returns: Execution result, see `DoResult`.
    static func `do`(_ table: Module.Table, param: Any? = nil) -> DoResult {
        return `do`(table.url, param: param)
    }
    
    /// Execute router by `String`.
    ///
    /// - Parameters:
    ///   - url: Router url to be executed.
    ///   - param: Parameters required for this router.
    /// - Returns: Execution result, see `DoResult`.
    static func `do`(_ url: String, param: Any? = nil) -> DoResult {
        
        guard let factory = RouterFactory.shared.doHandlerFactories[url] else {
            return .failure(.notHandler(url: url))
        }
        
        return factory(url, param)
    }
}

// MARK: - Get

public extension RaRouter {
    
    /// Execute router by `Module.Table`, And get the result it returns.
    ///
    /// - Parameters:
    ///   - type: Type of result.
    ///   - table: Router to be executed.
    ///   - param: Parameters required for this router.
    /// - Returns: Execution result, see `GetResult`.
    static func get<T>(of type: T.Type, from table: Module.Table, param: Any? = nil) -> GetResult<T> {
        return get(of: type, from: table.url, param: param)
    }
    
    /// Execute router by `String`, And get the result it returns.
    ///
    /// - Parameters:
    ///   - type: Type of result.
    ///   - url: Router url to be executed.
    ///   - param: Parameters required for this router.
    /// - Returns: Execution result, see `GetResult`.
    static func get<T>(of type: T.Type, from url: String, param: Any? = nil) -> GetResult<T> {
        
        guard let factory = RouterFactory.shared.getHandlerFactories[url] else {
            return .failure(.notHandler(url: url))
        }
        
        return factory(url, param).map {
            if let result = $0 as? T { return result }
            throw RouterError.convertTypeFailed(url: url)
        }
    }
}

// MARK: - ViewController

public extension RaRouter {
    
    /// Execute router by `Module.Table`, And get the returned `UIViewController` subclass.
    ///
    /// - Parameters:
    ///   - table: Router to be executed.
    ///   - param: Parameters required for this router.
    /// - Returns: Execution result, see `ViewControllerResult`.
    static func viewController(from table: Module.Table, param: Any? = nil) -> ViewControllerResult {
        return viewController(from: table.url, param: param)
    }
    
    /// Execute router by `String`, And get the returned `UIViewController` subclass.
    ///
    /// - Parameters:
    ///   - url: Router url to be executed.
    ///   - param: Parameters required for this router.
    /// - Returns: Execution result, see `ViewControllerResult`.
    static func viewController(from url: String, param: Any? = nil) -> ViewControllerResult {
        
        guard let factory = RouterFactory.shared.viewControllerHandlerFactories[url] else {
            return .failure(.notHandler(url: url))
        }
        
        return factory(url, param)
    }
}

// MARK: - Private Tools

fileprivate extension Result where Failure == RouterError {
    
    func map<NewSuccess>(_ transform: (Success) throws -> NewSuccess) -> Result<NewSuccess, Failure> {
        
        switch self {
        case .success(let success):
            
            do {
                return .success(try transform(success))
                
            } catch {
                return .failure(error as! Failure)
            }
            
        case .failure(let error):
            return .failure(error)
        }
    }
}
