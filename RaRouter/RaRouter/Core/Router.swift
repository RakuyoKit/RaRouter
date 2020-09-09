//
//  Router.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/7.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// The default implementation of `RaRouter`
public enum Router<Module: ModuleRouter>: RaRouter { }

/// A global component.
///
/// Can be used to provide a default generic type for `RaRouter`.
///
/// If there is a better choice, please **never** use this.
public struct Global: ModuleRouter {
    
    public struct Factory: RouterFactory {
        public init() {}
    }
    
    public enum Table: String, RouterTable {
        
        /// Nothing here. Perhaps it can be used to represent some kind of placeholder?
        case none = "RaRouter://Global/none"
    }
}

extension Global.Factory: FactoryMediator {
    
    public var source: RouterFactory { RealFactory() }
    
    private struct RealFactory: RouterFactory {
        // The Global module does not contain any executable routing. So its factory should be empty
    }
}
