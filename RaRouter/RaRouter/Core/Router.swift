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
/// Can be used to provide a default generic type for `Router`.
///
/// If there is a better choice, please **never** use this.
public struct Global: ModuleRouter {
    
    public struct Factory: RouterFactory {
        public init() {}
    }
    
    public enum Table: String, RouterTable {
        
        case none = "RaRouter://Global/none"
    }
}

extension Global.Factory: FactoryMediator {
    
    public var source: RouterFactory { RealFactory() }
    
    private struct RealFactory: RouterFactory {}
}
