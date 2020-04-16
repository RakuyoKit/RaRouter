//
//  Interface.swift
//  ModuleARouter
//
//  Created by Rakuyo on 2020/4/15.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import RaRouter

public enum ModuleA: ModuleRouter {
    
    public typealias Table = RouterTable
    
    public enum RouterTable: String, RouterTableProtocol {
        
        public var url: String { rawValue }
        
        case dataSource  = "demo://ModuleA/rootController/dataSource"
        case print       = "demo://ModuleA/print"
        case requestPush = "demo://ModuleA/request/pushPermission"
        case alert       = "demo://ModuleA/alert"
    }
}

public extension Router where Module == ModuleA {
    
    /// Get data soucce for `RootController`
    ///
    /// - Throws: `RaRouter.RouterError`
    /// - Returns: data soucce of `RootController`
    static func getDataSource() throws -> [SectionDataSource]? {
        return try Router.getResult(.dataSource) as? [SectionDataSource]
    }
    
    /// `print(value)`
    ///
    /// - Parameter value: What to print
    /// - Throws: `RaRouter.RouterError`
    static func print(_ value: Any) throws {
        try Router.do(.print, param: value)
    }
    
    /// Request push permission
    ///
    /// - Throws: `RaRouter.RouterError`
    static func requestPushPermission() throws {
        try Router.do(.requestPush)
    }
    
    /// show alert
    ///
    /// - Parameters:
    ///   - title: title of alert
    ///   - message: message of alert
    /// - Throws: `RaRouter.RouterError`
    static func alert(title: String? = nil, message: String? = nil) throws -> UIViewController {
        return try Router.viewController(.alert, param: (title, message))
    }
}
