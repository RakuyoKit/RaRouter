//
//  Register.swift
//  RootController
//
//  Created by Rakuyo on 2020/4/15.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import RaRouter
import RootControllerRouter

private class RootControllerRegister: RouterRegister {
    
    static func register() {
        
        let router = Router<RootController>.self
        
        router.register(for: .create) { (url, value) -> ViewControllerResult in
            return .success(RootViewController(style: .grouped))
        }
    }
}
