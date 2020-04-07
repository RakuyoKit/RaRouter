//
//  Router+Extension.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/7.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import UIKit

// MARK: - Execute

public extension RaRouter {
    
    static func `do`(_ table: Module.Table, param: Any? = nil) throws {
        try `do`(table.url, param: param)
    }
    
    static func getResult(_ table: Module.Table, param: Any? = nil) throws -> Any? {
        return try getResult(table.url, param: param)
    }
    
    static func viewController(_ table: Module.Table, param: Any? = nil) throws -> UIViewController {
        return try viewController(table.url, param: param)
    }
}

// MARK: - Execute With String URL

public extension RaRouter {
    
    static func `do`(_ url: String, param: Any? = nil) throws {
        
        guard let factory = RouterFactory.shared.doHandlerFactories[url] else {
            throw RouterError.notHandler(url: url)
        }
        
        try factory(url, param)
    }
    
    static func getResult(_ url: String, param: Any? = nil) throws -> Any? {
        
        guard let factory = RouterFactory.shared.resultHandlerFactories[url] else {
            throw RouterError.notHandler(url: url)
        }
        
        return try factory(url, param)
    }
    
    static func viewController(_ url: String, param: Any? = nil) throws -> UIViewController {
        
        guard let factory = RouterFactory.shared.viewControllerHandlerFactories[url] else {
            throw RouterError.notHandler(url: url)
        }
        
        return try factory(url, param)
    }
}

// MARK: - Register

public extension RaRouter {
    
    static func register(for table: Module.Table, _ factory: @escaping DoHandlerFactory) {
        register(for: table.url, factory)
    }
    
    static func register(for table: Module.Table, _ factory: @escaping ResultHandlerFactory) {
        register(for: table.url, factory)
    }
    
    static func register(for table: Module.Table, _ factory: @escaping ViewControllerHandlerFactory) {
        register(for: table.url, factory)
    }
}

// MARK: - Register With String URL

public extension RaRouter {
    
    static func register(for url: String, _ factory: @escaping DoHandlerFactory) {
        RouterFactory.shared.doHandlerFactories[url] = factory
    }
    
    static func register(for url: String, _ factory: @escaping ResultHandlerFactory) {
        RouterFactory.shared.resultHandlerFactories[url] = factory
    }
    
    static func register(for url: String, _ factory: @escaping ViewControllerHandlerFactory) {
        RouterFactory.shared.viewControllerHandlerFactories[url] = factory
    }
}

// MARK: - Register Module

public typealias Modules = Global

public extension RaRouter where Module == Modules {
    
    /// 调用该方法以初始化组件
    static func initialize() { _initialize }
}

private let _initialize: Void = {
    
    let typeCount = Int(objc_getClassList(nil, 0))
    let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
    let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
    
    objc_getClassList(autoreleasingTypes, Int32(typeCount))
    
    for index in 0 ..< typeCount {
        (types[index] as? RouterRegister.Type)?.register()
    }
    
    types.deallocate()
}()
