//
//  TestRegister.swift
//  RaRouterTests
//
//  Created by MBCore on 2020/4/26.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

@testable import RaRouter

private class TestRegister: RouterRegister {

    static func register() {
        
        let router = Router<Test>.self
        
        router.register(for: .setTestStringToToolSingleton) { (url, value) -> DoResult in

            guard let param = value as? String else {
                return .failure(.notHandler(url: url))
            }

            ToolSingleton.shared.value = param

            return .success(())
        }
        
        router.register(for: .getTestStringFromToolSingleton) { (url, value) -> GetResult<Any> in
            return .success(ToolSingleton.shared.value as Any)
        }
    }
}
