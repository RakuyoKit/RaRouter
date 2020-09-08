//
//  Initialize.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/17.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// If the module needs to perform certain operations when the App starts,
/// and at the same time want to manually control the order of code execution (compared to other non-routing codes).
///
/// Then you can follow the protocol and write related code in the `initialize()` method.
///
/// - Note: The execution of the `initialize()` method actually depends on the execution timing of the `RaRouter<Global>.initialize()` method. For details, please refer to: `Router+Initialize.swift` Other content in the file
public protocol NeedInitialized {
     
    static func initialize()
}

public extension RaRouter where Module == Global {
    
    /// Call this method to initialize the components
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
