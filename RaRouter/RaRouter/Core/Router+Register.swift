//
//  Router+Register.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/17.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

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
    
//    for index in 0 ..< typeCount {
//        (types[index] as? RouterRegister.Type)?.register()
//    }
    
    types.deallocate()
}()
