//
//  TestInterface.swift
//  RaRouterTests
//
//  Created by MBCore on 2020/4/26.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

@testable import RaRouter

enum Test: ModuleRouter {
    
    typealias Table = RouterTable
    
    enum RouterTable: String, RouterTableProtocol {
        
        var url: String { rawValue }
        
        case setTestStringToToolSingleton = "raRouter://test/do/ToolSingleton"
        case getTestStringFromToolSingleton = "raRouter://test/get/ToolSingleton"
    }
}

extension Router where Module == Test {
    
    static func testDoByToolSingleton(value: String) -> DoResult {
        return Router.do(.setTestStringToToolSingleton, param: value)
    }
    
    static func getStringFromToolSingleton() -> GetResult<String> {
        return Router.get(of: String.self, from: .getTestStringFromToolSingleton)
    }
}
