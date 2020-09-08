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
    
    /// Used to store the route to be executed
    associatedtype Factory: RouterFactory
    
    /// refers to the router table.
    associatedtype Table: RouterTable
}
