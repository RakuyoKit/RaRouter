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
public typealias ResultHandlerFactory = (_ url: String, _ values: Any?) -> Result<Any, RouterError>

public typealias ViewControllerResult = Result<UIViewController, RouterError>
public typealias ViewControllerHandlerFactory = (_ url: String, _ values: Any?) -> ViewControllerResult

/// 用以存储注册过的路由
public class RouterFactory {
    
    /// 单例
    public static let shared = RouterFactory()
    
    private init() {}
    
    /// 用以存储 **执行操作** 类型的路由
    public lazy var doHandlerFactories: [String : DoHandlerFactory]  = [:]
    
    /// 用以存储 **执行操作后，获取操作的返回值** 类型的路由
    public lazy var resultHandlerFactories: [String : ResultHandlerFactory]  = [:]
    
    /// 用以存储 **执行操作后，获取控制器** 类型的路由
    public lazy var viewControllerHandlerFactories: [String : ViewControllerHandlerFactory]  = [:]
}
