//
//  Register.swift
//  RootController
//
//  Created by Rakuyo on 2020/4/15.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import RaRouter
import RootControllerRouter

extension RootController.Factory: FactoryMediator {

    public var source: RouterFactory { RealFactory() }

    private struct RealFactory: RouterFactory {
        
        lazy var viewControllerHandlerFactories: [String : ViewControllerHandlerFactory]? = [
            
            RootController.Table.create.rawValue : { (url, value) in
                
                let controller = RootViewController(style: .grouped)
                
                return .success(controller)
            }
        ]
    }
}
