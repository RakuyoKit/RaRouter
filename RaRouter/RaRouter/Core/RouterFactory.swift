//
//  RouterFactory.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/9/8.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// The middleman between the stored object and the caller.
public protocol FactoryMediator {
    
    /// Data source. The real storage object will be obtained through this attribute.
    var source: RouterFactory { get }
}

/// Used to store the content of the route to be executed and provide an accessible interface to the caller.
public protocol RouterFactory {
    
    /// Require initialization method.
    init()
    
    /// Used to store `do` router.
    var doHandlerFactories: [String : DoHandlerFactory]? { mutating get }
    var asynDoHandlerFactories: [String : AsynDoHandlerFactory]? { mutating get }
    
    /// Used to store `get` router.
    var getHandlerFactories: [String : GetHandlerFactory]? { mutating get }
    var asynGetHandlerFactories: [String : AsynGetHandlerFactory]? { mutating get }
    
    /// Used to store `viewController` router.
    var viewControllerHandlerFactories: [String : ViewControllerHandlerFactory]? { mutating get }
    var asynViewControllerHandlerFactories: [String : AsynViewControllerHandlerFactory]? { mutating get }
}

public extension RouterFactory {
    
    private var mediator: FactoryMediator? { self as? FactoryMediator }
    
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
