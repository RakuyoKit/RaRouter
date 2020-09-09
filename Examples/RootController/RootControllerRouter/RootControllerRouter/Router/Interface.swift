//
//  Interface.swift
//  RootControllerRouter
//
//  Created by Rakuyo on 2020/4/16.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import RaRouter

public enum RootController: ModuleRouter {
    
    public struct Factory: RouterFactory {
        public init() {}
    }
    
    public enum Table: String, RouterTable {
        
        case create = "Demo://RootController/create"
    }
}

public extension Router where Module == RootController {
    
    /// Create Root ViewController
    /// 
    /// - Returns: `RootViewController` without `UINavigationController`
    static func create() -> ViewControllerResult {
        return Router.viewController(from: .create)
    }
}
