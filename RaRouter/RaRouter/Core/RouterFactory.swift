//
//  RouterFactory.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/7.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import UIKit

public typealias DoResult = Result<Void, RouterError>
public typealias DoHandlerFactory = (_ url: String, _ values: Any?) -> DoResult

public typealias GetResult<T> = Result<T, RouterError>
public typealias GetHandlerFactory<T> = (_ url: String, _ values: Any?) -> GetResult<T>

public typealias ViewControllerResult = Result<UIViewController, RouterError>
public typealias ViewControllerHandlerFactory = (_ url: String, _ values: Any?) -> ViewControllerResult

/// Used to store registered routers
public class RouterFactory {
    
    /// Singleton
    public static let shared = RouterFactory()
    
    private init() {}
    
    /// Used to store `do` router
    public lazy var doHandlerFactories: [String : DoHandlerFactory]  = [:]
    
    /// Used to store `get` router
    public lazy var getHandlerFactories: [String : (String, Any?) -> Result<Any, RouterError>]  = [:]
    
    /// Used to store `viewController` router
    public lazy var viewControllerHandlerFactories: [String : ViewControllerHandlerFactory]  = [:]
}
