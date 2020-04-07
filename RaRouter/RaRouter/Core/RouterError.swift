//
//  RouterError.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/7.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// 可能会出现的错误类型
public enum RouterError: Error {
    
    /// 路由地址没有匹配的内容，即该路由地址没有注册
    case notHandler(url: String)
    
    /// 所传的参数错误
    case parameterError(url: String, parameter: Any?)
    
    /// 所返回的控制器为空。
    /// 
    /// 一般情况下，控制器的创建结果不应该为空。
    /// 所以 `ViewControllerHandlerFactory` 设计为返回 `UIViewController`
    /// 
    /// 但是为了以防万一，例如通过接口获取某些数据失败，那么就无法创建目标控制器。
    /// 所以组件提供了该错误。当控制器为空时可抛出该错误给外界使用。
    /// 
    /// 目前仅额外提供 `message` 表明错误原因
    case controllerNil(url: String, parameter: Any?, message: String)
}
