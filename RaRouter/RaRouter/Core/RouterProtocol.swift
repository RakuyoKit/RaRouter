//
//  RouterProtocol.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/7.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// 路由
public protocol RaRouter {
    
    /// 模块泛型
    associatedtype Module: ModuleRouter
}

/// 用来表明，遵守该协议的类型，是某个模块的路由组件
public protocol ModuleRouter {
    
    /// 用来表示该路由的路由表
    associatedtype Table: RouterTableProtocol
}

/// 用来表明，遵守该协议的类型，是某个模块的路由的路由表
public protocol RouterTableProtocol: Codable {
    
    /// 路由表需要实现该属性，在其中 `return rawValue`
    ///
    /// eg: `var url: String { rawValue }`
    var url: String { get }
}

/// 各个路由组件的注册类应该实现该协议，用以注册组件路由
public protocol RouterRegister: class {
    
    /// 组件需要实现该方法以注册路由
    static func register()
}
