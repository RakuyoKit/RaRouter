//
//  RaRouter.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/9/8.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// Router.
public protocol RaRouter {
    
    /// refers to the module.
    associatedtype Module: ModuleRouter
}

// MARK: - Execute Router

// MARK: Do

public extension RaRouter {
    
    /// Execute router by `Module.Table`.
    ///
    /// - Parameters:
    ///   - table: Router to be executed.
    ///   - param: Parameters required for this router.
    /// - Returns: Execution result, see `DoResult`.
    static func `do`(_ table: Module.Table, param: Any? = nil) -> DoResult {
        return `do`(table.rawValue, param: param)
    }
    
    /// Execute router by `String`.
    ///
    /// - Parameters:
    ///   - url: Router url to be executed.
    ///   - param: Parameters required for this router.
    /// - Returns: Execution result, see `DoResult`.
    static func `do`(_ url: String, param: Any? = nil) -> DoResult {
        
        guard let factories = Module.Factory.init().doHandlerFactories else {
            return .failure(.factoryNil(url: url))
        }
        
        guard let factory = factories[url] else {
            return .failure(.notHandler(url: url))
        }
        
        return factory(url, param)
    }
    
    /// Execute router by `Module.Table`.
    ///
    /// - Parameters:
    ///   - table: Router to be executed.
    ///   - param: Parameters required for this router.
    ///   - callback: Used for callback route execution result. You need to manage the thread yourself. see `DoResultCallback`.
    static func `do`(_ table: Module.Table, param: Any? = nil, callback: @escaping DoResultCallback) {
        `do`(table.rawValue, param: param, callback: callback)
    }
    
    /// Execute router by `String`.
    ///
    /// - Parameters:
    ///   - url: Router url to be executed.
    ///   - param: Parameters required for this router.
    ///   - callback: Used for callback route execution result. You need to manage the thread yourself. see `DoResultCallback`.
    static func `do`(_ url: String, param: Any? = nil, callback: @escaping DoResultCallback) {
        
        guard let factories = Module.Factory.init().asynDoHandlerFactories else {
            callback(.failure(.factoryNil(url: url)))
            return
        }
        
        guard let factory = factories[url] else {
            callback(.failure(.notHandler(url: url)))
            return
        }
        
        factory(url, param, callback)
    }
}

// MARK: Get

public extension RaRouter {
    
    /// Execute router by `Module.Table`, And get the result it returns.
    ///
    /// - Parameters:
    ///   - type: Type of result.
    ///   - table: Router to be executed.
    ///   - param: Parameters required for this router.
    /// - Returns: Execution result, see `GetResult`.
    static func get<T>(of type: T.Type, from table: Module.Table, param: Any? = nil) -> GetResult<T> {
        return get(of: type, from: table.rawValue, param: param)
    }
    
    /// Execute router by `String`, And get the result it returns.
    ///
    /// - Parameters:
    ///   - type: Type of result.
    ///   - url: Router url to be executed.
    ///   - param: Parameters required for this router.
    /// - Returns: Execution result, see `GetResult`.
    static func get<T>(of type: T.Type, from url: String, param: Any? = nil) -> GetResult<T> {
        
        guard let factories = Module.Factory.init().getHandlerFactories else {
            return .failure(.factoryNil(url: url))
        }
        
        guard let factory = factories[url] else {
            return .failure(.notHandler(url: url))
        }
        
        return factory(url, param).map {
            if let result = $0 as? T { return result }
            throw RouterError.convertTypeFailed(url: url)
        }
    }
    
    /// Execute router by `Module.Table`, And get the result it returns.
    ///
    /// - Parameters:
    ///   - type: Type of result.
    ///   - table: Router to be executed.
    ///   - param: Parameters required for this router.
    ///   - callback: Used for callback route execution result. You need to manage the thread yourself.
    static func get<T>(of type: T.Type, from table: Module.Table, param: Any? = nil, callback: @escaping (GetResult<T>) -> Void) {
        get(of: type, from: table.rawValue, param: param, callback: callback)
    }
    
    /// Execute router by `String`, And get the result it returns.
    ///
    /// - Parameters:
    ///   - type: Type of result.
    ///   - url: Router url to be executed.
    ///   - param: Parameters required for this router.
    ///   - callback: Used for callback route execution result. You need to manage the thread yourself.
    static func get<T>(of type: T.Type, from url: String, param: Any? = nil, callback: @escaping (GetResult<T>) -> Void) {
        
        guard let factories = Module.Factory.init().asynGetHandlerFactories else {
            callback(.failure(.factoryNil(url: url)))
            return
        }
        
        guard let factory = factories[url] else {
            callback(.failure(.notHandler(url: url)))
            return
        }
        
        factory(url, param, {
            
            callback($0.map {
                if let result = $0 as? T { return result }
                throw RouterError.convertTypeFailed(url: url)
            })
        })
    }
}

public extension GetResult {
    
    /// When an error occurs, it will return `default`
    func get(default: Success) -> Success {
        switch self {
        case .success(let success): return success
        case .failure(_): return `default`
        }
    }
}

// MARK: ViewController

public extension RaRouter {
    
    /// Execute router by `Module.Table`, And get the returned `UIViewController` subclass.
    ///
    /// - Parameters:
    ///   - table: Router to be executed.
    ///   - param: Parameters required for this router.
    /// - Returns: Execution result, see `ViewControllerResult`.
    static func viewController(from table: Module.Table, param: Any? = nil) -> ViewControllerResult {
        return viewController(from: table.rawValue, param: param)
    }
    
    /// Execute router by `String`, And get the returned `UIViewController` subclass.
    ///
    /// - Parameters:
    ///   - url: Router url to be executed.
    ///   - param: Parameters required for this router.
    /// - Returns: Execution result, see `ViewControllerResult`.
    static func viewController(from url: String, param: Any? = nil) -> ViewControllerResult {
        
        guard let factories = Module.Factory.init().viewControllerHandlerFactories else {
            return .failure(.factoryNil(url: url))
        }
        
        guard let factory = factories[url] else {
            return .failure(.notHandler(url: url))
        }
        
        return factory(url, param)
    }
    
    /// Execute router by `Module.Table`, And get the returned `UIViewController` subclass.
    ///
    /// - Parameters:
    ///   - table: Router to be executed.
    ///   - param: Parameters required for this router.
    ///   - callback: Used for callback route execution result. You need to manage the thread yourself. see `ViewControllerResultCallback`.
    static func viewController(from table: Module.Table, param: Any? = nil, callback: @escaping ViewControllerResultCallback) {
        viewController(from: table.rawValue, param: param, callback: callback)
    }
    
    /// Execute router by `String`, And get the returned `UIViewController` subclass.
    ///
    /// - Parameters:
    ///   - url: Router url to be executed.
    ///   - param: Parameters required for this router.
    ///   - callback: Used for callback route execution result. You need to manage the thread yourself. see `ViewControllerResultCallback`.
    static func viewController(from url: String, param: Any? = nil, callback: @escaping ViewControllerResultCallback) {
        
        guard let factories = Module.Factory.init().asynViewControllerHandlerFactories else {
            callback(.failure(.factoryNil(url: url)))
            return
        }
        
        guard let factory = factories[url] else {
            callback(.failure(.notHandler(url: url)))
            return
        }
        
        factory(url, param, callback)
    }
}

// MARK: Private Tools

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
