//
//  ModuleRouter.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/9/8.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// Used to indicate that the type of compliance with the protocol is a router component of a module.
public protocol ModuleRouter {
    
    /// Used to manage the routing address provided by the module.
    associatedtype Table: RouterTable
    
    /// Used to store the corresponding implementation of the routing provided by the module.
    associatedtype Factory: RouterFactory
}
