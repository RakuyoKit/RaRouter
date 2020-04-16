//
//  Interface.swift
//  RootControllerRouter
//
//  Created by Rakuyo on 2020/4/16.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import RaRouter

public enum RootController: ModuleRouter {
    
    public typealias Table = RouterTable
    
    public enum RouterTable: String, RouterTableProtocol {
        
        public var url: String { rawValue }
        
        case create = "demo://RootController/create"
    }
}

public extension Router where Module == RootController {
    
    /// Create Root ViewController
    /// 
    /// - Throws: `RaRouter.RouterError`
    /// - Returns: `RootViewController` without `UINavigationController`
    static func create() throws -> UIViewController {
        return try Router.viewController(.create)
    }
}
