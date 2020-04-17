//
//  Router+Register.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/17.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

// MARK: - Do

public extension RaRouter {
    
    static func register(for table: Module.Table, _ factory: @escaping DoHandlerFactory) {
        register(for: table.url, factory)
    }
    
    static func register(for url: String, _ factory: @escaping DoHandlerFactory) {
        RouterFactory.shared.doHandlerFactories[url] = factory
    }
}

// MARK: - GetResult

public extension RaRouter {
    
    static func register(for table: Module.Table, _ factory: @escaping ResultHandlerFactory) {
        register(for: table.url, factory)
    }
    
    static func register(for url: String, _ factory: @escaping ResultHandlerFactory) {
        RouterFactory.shared.resultHandlerFactories[url] = factory
    }
}

// MARK: - ViewController

public extension RaRouter {
    
    static func register(for table: Module.Table, _ factory: @escaping ViewControllerHandlerFactory) {
        register(for: table.url, factory)
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
