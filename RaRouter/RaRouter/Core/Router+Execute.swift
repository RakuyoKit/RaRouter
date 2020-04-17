//
//  Router+Execute.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/17.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import UIKit

// MARK: - Do

public extension RaRouter {
    
    /// 根据 `table` 执行某一个路由。
    ///
    /// - Parameters:
    ///   - table: 所要执行的路由
    ///   - param: 该路由所需要的参数
    /// - Returns: 执行结果，详见 `DoResult` 类型
    static func `do`(_ table: Module.Table, param: Any? = nil) -> DoResult {
        return `do`(table.url, param: param)
    }
    
    /// 根据 `url` 执行某一个路由。
    ///
    /// - Parameters:
    ///   - url: 所要执行的路由的地址
    ///   - param: 该路由所需要的参数
    /// - Returns: 执行结果，详见 `DoResult` 类型
    static func `do`(_ url: String, param: Any? = nil) -> DoResult {
        
        guard let factory = RouterFactory.shared.doHandlerFactories[url] else {
            return .failure(.notHandler(url: url))
        }
        
        return factory(url, param)
    }
}

// MARK: - GetResult

public extension RaRouter {
    
    /// 根据 `table` 执行某一个路由，并获得其返回的结果
    ///
    /// - Parameters:
    ///   - type: 返回的结果的类型
    ///   - table: 所要执行的路由
    ///   - param: 该路由所需要的参数
    /// - Returns: 执行结果，详见 `GetResult` 类型
    static func get<T>(of type: T.Type, from table: Module.Table, param: Any? = nil) -> GetResult<T> {
        return get(of: type, from: table.url, param: param)
    }
    
    static func getResult<T>(of type: T.Type, from url: String, param: Any? = nil) -> GetResult<T> {
    static func get<T>(of type: T.Type, from url: String, param: Any? = nil) -> GetResult<T> {
        
        guard let factory = RouterFactory.shared.resultHandlerFactories[url] else {
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
    
    static func viewController(from table: Module.Table, param: Any? = nil) -> ViewControllerResult {
        return viewController(from: table.url, param: param)
    }
    
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
