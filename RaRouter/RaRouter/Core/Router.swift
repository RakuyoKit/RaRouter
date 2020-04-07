//
//  Router.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/7.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// 默认提供的路由
public enum Router<Module: ModuleRouter>: RaRouter { }

/// 默认的全局路由组件，可通过该组件为 `Router` 提供泛型，执行 `Router` 的一些默认方法
public enum Global: ModuleRouter {
    
    public typealias Table = RouterTable
    
    public enum RouterTable: String, RouterTableProtocol {
        
        public var url: String { rawValue }
        
        case none = "mbc://global/none"
    }
}
