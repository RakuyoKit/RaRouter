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
    
    /// Used to store the route to be executed
    associatedtype Factory: FactoryProtocol
    
    /// refers to the router table.
    associatedtype Table: RawRepresentable where Table.RawValue == String
}

/// The middleman between the stored object and the caller
public protocol FactoryMediatorProtocol {
    
    /// Data source. The real storage object will be obtained through this attribute
    var source: FactoryProtocol { get }
}

/// Used to store the content of the route to be executed and provide an accessible interface to the caller
public protocol FactoryProtocol {
    
    /// Require initialization method
    init()
    
    /// Used to store `do` router
    var doHandlerFactories: [String : DoHandlerFactory]? { mutating get }
    var asynDoHandlerFactories: [String : AsynDoHandlerFactory]? { mutating get }
    
    /// Used to store `get` router
    var getHandlerFactories: [String : GetHandlerFactory]? { mutating get }
    var asynGetHandlerFactories: [String : AsynGetHandlerFactory]? { mutating get }
    
    /// Used to store `viewController` router
    var viewControllerHandlerFactories: [String : ViewControllerHandlerFactory]? { mutating get }
    var asynViewControllerHandlerFactories: [String : AsynViewControllerHandlerFactory]? { mutating get }
}

public extension FactoryProtocol {
    
    private var mediator: FactoryMediatorProtocol? { self as? FactoryMediatorProtocol }
    
    var doHandlerFactories: [String : DoHandlerFactory]? {
        var source = mediator?.source
        return source?.doHandlerFactories
    }
    
    var asynDoHandlerFactories: [String : AsynDoHandlerFactory]? {
        var source = mediator?.source
        return source?.asynDoHandlerFactories
    }
    
    var getHandlerFactories: [String : GetHandlerFactory]? {
        var source = mediator?.source
        return source?.getHandlerFactories
    }
    
    var asynGetHandlerFactories: [String : AsynGetHandlerFactory]? {
        var source = mediator?.source
        return source?.asynGetHandlerFactories
    }
    
    var viewControllerHandlerFactories: [String : ViewControllerHandlerFactory]? {
        var source = mediator?.source
        return source?.viewControllerHandlerFactories
    }
    
    var asynViewControllerHandlerFactories: [String : AsynViewControllerHandlerFactory]? {
        var source = mediator?.source
        return source?.asynViewControllerHandlerFactories
    }
}
