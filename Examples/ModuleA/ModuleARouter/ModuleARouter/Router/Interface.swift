//
//  Interface.swift
//  ModuleARouter
//
//  Created by Rakuyo on 2020/4/15.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import RaRouter

public enum ModuleA: ModuleRouter {
    
    public struct Factory: RouterFactory {
        public init() {}
    }
    
    public enum Table: String, RouterTable {
        
        case dataSource        = "Demo://ModuleA/rootController/dataSource"
        case print             = "Demo://ModuleA/print"
        case requestPush       = "Demo://ModuleA/request/pushPermission"
        case alert             = "Demo://ModuleA/controller/alert"
        case detectMemoryLeaks = "Demo://ModuleA/controller/detectMemoryLeaks"
    }
}

public extension Router where Module == ModuleA {
    
    /// Get data soucce for `RootController`
    ///
    /// - Returns: Data soucce of `RootController`
    static func getDataSource() -> GetResult<[SectionDataSource]> {
        return Router.get(of: [SectionDataSource].self, from: .dataSource)
    }
    
    /// `print(value)`
    ///
    /// - Returns: Execute Result
    static func print(_ value: Any) -> DoResult {
        return Router.do(.print, param: value)
    }
    
    /// Request push permission
    /// 
    /// - Returns: Execute Result
    static func requestPushPermission() -> DoResult {
        return Router.do(.requestPush)
    }
    
    /// Show alert
    ///
    /// - Parameters:
    ///   - title: title of alert
    ///   - message: message of alert
    /// - Returns: `UIAlertController`
    static func alert(title: String? = nil, message: String? = nil) -> ViewControllerResult {
        return Router.viewController(from: .alert, param: (title, message))
    }
    
    /// Create a controller for detecting memory leaks
    ///
    /// - Returns: Controller
    static func createDetectMemoryLeaks() -> ViewControllerResult {
        return Router.viewController(from: .detectMemoryLeaks)
    }
}
