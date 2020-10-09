//
//  GlobalRouter.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/7.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// A global component. The route can be called without specifying a specific module.
///
/// Any route that follows the following rules can be called by `Router <Global>`.
///
/// - Rules:
///     1. `ModuleRouter.Factory` must be a **final class** and inherit from `NSObject`.
///     2. Use `@objc(name)` to rename the class.
///     3. The rule of *name* in the second is: The first level + `"Factory"` of the routing string to be executed.
///
/// Examples of using the `Test` module, When I want to execute `Test.Table.none` through `Router<Global>, I should implement the `Test` module like this:
///
/// ```swift
/// public enum Test: ModuleRouter {
///
///     @objc(TestFactory)
///     public final class Factory: NSObject, RouterFactory { }
///
///     public enum Table: String, RouterTable {
///         case none = "RaRouter://Test/none"
///     }
/// }
/// ```
///
/// - Note: If there is a better choice, please **never** use this.
public struct Global: ModuleRouter {
    
    public struct Factory: RouterFactory {
        public init() {}
    }
    
    public enum Table: String, RouterTable {
        
        /// Nothing here. Perhaps it can be used to represent some kind of placeholder.
        case none = "RaRouter://Global/none"
    }
}

extension Global.Factory: FactoryMediator {
    
    public var source: RouterFactory { RealFactory() }
    
    private struct RealFactory: RouterFactory {
        // The Global module does not contain any executable routing. So its factory should be empty.
    }
}

// MARK: - Default implementation for Global

// MARK: Do

public extension RaRouter where Module == Global {
    
    static func`do`(_ table: RouterTable?, param: Any? = nil) -> DoResult {
        
        guard let url = table?.url else {
            return .failure(.tableNil)
        }
        
        guard let factories = createFactory(from: url)?.doHandlerFactories else {
            return .failure(.factoryNil(url: url))
        }
        
        guard let factory = factories[url] else {
            return .failure(.notHandler(url: url))
        }
        
        return factory(url, param)
    }
    
    static func `do`(_ table: RouterTable?, param: Any? = nil, callback: @escaping DoResultCallback) {
        
        guard let url = table?.url else {
            callback(.failure(.tableNil))
            return
        }
        
        guard let factories = createFactory(from: url)?.asynDoHandlerFactories else {
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

public extension RaRouter where Module == Global {
    
    static func get<T>(of type: T.Type, from table: RouterTable?, param: Any? = nil) -> GetResult<T> {
        
        guard let url = table?.url else {
            return .failure(.tableNil)
        }
        
        guard let factories = createFactory(from: url)?.getHandlerFactories else {
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
    
    static func get<T>(of type: T.Type, from table: RouterTable?, param: Any? = nil, callback: @escaping (GetResult<T>) -> Void) {
        
        guard let url = table?.url else {
            callback(.failure(.tableNil))
            return
        }
        
        guard let factories = createFactory(from: url)?.asynGetHandlerFactories else {
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

// MARK: ViewController

public extension RaRouter where Module == Global {
    
    static func viewController(from table: RouterTable?, param: Any? = nil) -> ViewControllerResult {
        
        guard let url = table?.url else {
            return .failure(.tableNil)
        }
        
        guard let factories = createFactory(from: url)?.viewControllerHandlerFactories else {
            return .failure(.factoryNil(url: url))
        }
        
        guard let factory = factories[url] else {
            return .failure(.notHandler(url: url))
        }
        
        return factory(url, param)
    }
    
    static func viewController(from table: RouterTable?, param: Any? = nil, callback: @escaping ViewControllerResultCallback) {
        
        guard let url = table?.url else {
            callback(.failure(.tableNil))
            return
        }
        
        guard let factories = createFactory(from: url)?.asynViewControllerHandlerFactories else {
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

private extension RaRouter where Module == Global {
    
    static func createFactory(from url: String) -> RouterFactory? {
        
        let urls = url.components(separatedBy: "/")
        
        guard urls.count > 3 else { return nil }
        
        let module = NSClassFromString(urls[2] + "Factory") as? NSObject.Type
        
        return module?.perform(Selector("new"))?.takeRetainedValue() as? RouterFactory
    }
}
