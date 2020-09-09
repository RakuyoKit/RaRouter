//
//  Initialize.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/17.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// After implementing this protocol,
/// your module components will gain the ability to execute certain methods at the same time the App is started
///
/// If the module needs to perform certain operations when the App starts,
/// and at the same time want to manually control the order of code execution (relative to other non-routing codes).
/// Then you can follow the protocol and write related code in the `initialize()` method.
///
/// - Note: In fact, the execution timing of the `NeedInitialized.initialize()` method depends on the execution timing of the `RaRouter<Global>.initialize()` method. For details, please refer to the other content in the `Initialize.swift` file.
public protocol NeedInitialized: class {
    
    /// When `RaRouter<Global>.initialize()` is called, this method will also be called.
    ///
    /// - Note: This method will only be executed once.
    static func initialize()
}

public extension RaRouter where Module == Global {
    
    /// Call this method to initialize the components.
    ///
    /// You can choose to call this method in the `application(_:didFinishLaunchingWithOptions:)` method
    /// to allow all modules to have the ability to execute certain codes when the App starts.
    ///
    /// - Note: Repeated calls are invalid, the method will only be executed once.
    static func initialize() { _initialize }
}

private let _initialize: Void = {
    
    let typeCount = Int(objc_getClassList(nil, 0))
    let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
    let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
    
    objc_getClassList(autoreleasingTypes, Int32(typeCount))
    
    for index in 0 ..< typeCount {
        (types[index] as? NeedInitialized.Type)?.initialize()
    }
    
    types.deallocate()
}()
