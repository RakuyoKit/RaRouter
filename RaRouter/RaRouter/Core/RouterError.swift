//
//  RouterError.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/7.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// Possible errors
public enum RouterError: Error {
    
    /// When executing routing, the factory used to obtain the closure corresponding to the url is `nil`
    case factoryNil(url: String)
    
    /// The `url` does not match, that is, the `url` is not registered.
    case notHandler(url: String)
    
    /// Parameter is wrong, please check if `parameter` is the parameter required by `url`.
    case parameterError(url: String, parameter: Any?)
    
    /// Failed to convert result to `type` when execute `get(of:from:param:)` router.
    case convertTypeFailed(url: String)
    
    /// The returned result is nil.
    ///
    /// If you want the `get` type routing operation to return a non-nil result,
    /// but the actual execution of the route may be `nil`, you have to use `return` to terminate the routing execution,
    /// you can try to return this error
    case resultNil(url: String, parameter: Any?, message: String)
    
    /// The returned controller is nil.
    ///
    /// Just as we provide `viewController` routing operations separately based on `get`,
    /// we provide `controllerNil` errors separately based on the `resultNil` errors
    ///
    /// In general, the creation result of the controller should not be nil.
    /// So the return value of `ViewControllerHandlerFactory` is` Result<UIViewController, RouterError>` instead of `Result<UIViewController?, RouterError>?`
    ///
    /// But just in case:
    ///
    /// For example, in some cases, some necessary data must be obtained through the network before creating a controller. If these data collections fail, the target controller cannot be created.
    ///
    /// So we provide this error type, you can throw this error when the target controller cannot be created.
    /// 
    /// Currently only additional `message` is provided to indicate the cause of the error
    case controllerNil(url: String, parameter: Any?, message: String)
    
    /// Other types of errors
    ///
    /// When you encounter certain situations, you have to use "return" to terminate the routing execution,
    /// and the termination reason does not meet all the above error reasons, you can try to return the error
    case other(url: String, parameter: Any?, error: Error?)
}

// MARK: - Equatable

extension RouterError: Equatable {
    
    public static func == (lhs: RouterError, rhs: RouterError) -> Bool {
        
        switch (lhs, rhs) {
            
        case (.factoryNil(let lhsURL), .factoryNil(let rhsURL)):
            return lhsURL == rhsURL
            
        case (.notHandler(let lhsURL), .notHandler(let rhsURL)):
            return lhsURL == rhsURL
            
        case (.parameterError(let lhsURL, _), .parameterError(let rhsURL, _)):
            return lhsURL == rhsURL
            
        case (.convertTypeFailed(let lhsURL), .convertTypeFailed(let rhsURL)):
            return lhsURL == rhsURL
            
        case (.resultNil(let lhsURL, _, let lhsMessage), .resultNil(let rhsURL, _, let rhsMessage)):
            return (lhsURL == rhsURL) && (lhsMessage == rhsMessage)
            
        case (.controllerNil(let lhsURL, _, let lhsMessage), .controllerNil(let rhsURL, _, let rhsMessage)):
            return (lhsURL == rhsURL) && (lhsMessage == rhsMessage)
            
        case (.other(let lhsURL, _, _), .other(let rhsURL, _, _)):
            return lhsURL == rhsURL
            
        case (_, _): return false
        }
    }
}
