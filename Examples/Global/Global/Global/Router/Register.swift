//
//  Register.swift
//  Global
//
//  Created by Rakuyo on 2020/10/9.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import RaRouter
import GlobalDemoRouter

extension GlobalDemo.Factory: FactoryMediator {

    public var source: RouterFactory { RealFactory() }

    fileprivate struct RealFactory: RouterFactory {
        
        lazy var doHandlerFactories: [String : DoHandlerFactory]? = [
            
            GlobalDemo.Table.router.rawValue : { (url, value) in
                print("execution succeed")
                return .success(())
            }
        ]
    }
}
