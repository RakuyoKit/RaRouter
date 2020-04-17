//
//  RouterProtocol.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/7.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// Router.
public protocol RaRouter {
    
    /// refers to the module.
    associatedtype Module: ModuleRouter
}

/// Used to indicate that the type of compliance with the protocol is a router component of a module.
public protocol ModuleRouter {
    
    /// refers to the router table.
    associatedtype Table: RouterTableProtocol
}

/// Used to indicate that the type of compliance with the protocol is a router table of a module.
public protocol RouterTableProtocol: Codable {
    
    /// If you use `enum` to comply with the protocol,
    /// then you should return `rawValue` in this method.
    ///
    /// e.g. `var url: String { rawValue }`
    var url: String { get }
}

/// The registration class of each router component should implement this protocol to register component router
public protocol RouterRegister: class {
    
    /// Implement this method and register the route in this method
    static func register()
}
