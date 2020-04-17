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
    
    /// The `url` does not match, that is, the `url` is not registered.
    case notHandler(url: String)
    
    /// Parameter is wrong, please check if `parameter` is the parameter required by `url`.
    case parameterError(url: String, parameter: Any?)
    
    /// Failed to convert result to `type` when execute `get(of:from:param:)` router.
    case convertTypeFailed(url: String)
    
    /// The returned controller is nil.
    ///
    /// In general, the creation result of the controller should not be nil.
    /// So the return value of `ViewControllerHandlerFactory` is` UIViewController` instead of `UIViewController?`
    ///
    /// But just in case:
    ///
    /// For example, in some cases, some necessary data must be obtained through the network before creating a controller. If these data collections fail, the target controller cannot be created.
    ///
    /// So we provide this error type, you can throw this error when the target controller cannot be created.
    /// 
    /// Currently only additional `message` is provided to indicate the cause of the error
    case controllerNil(url: String, parameter: Any?, message: String)
}
