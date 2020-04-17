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

// MARK: - Get

public extension RaRouter {
    
    static func register<T>(for table: Module.Table, _ factory: @escaping GetHandlerFactory<T>) {
        register(for: table.url, factory)
    }
    
    static func register<T>(for url: String, _ factory: @escaping GetHandlerFactory<T>) {
        RouterFactory.shared.getHandlerFactories[url] = (factory as! GetHandlerFactory<Any>)
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

// make easier to understand
public typealias Modules = Global

public extension RaRouter where Module == Modules {
    
    /// Call this method to initialize the components
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
