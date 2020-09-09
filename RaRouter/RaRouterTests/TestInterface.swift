//
//  TestInterface.swift
//  RaRouterTests
//
//  Created by MBCore on 2020/4/26.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

@testable import RaRouter

public enum Test: ModuleRouter {
    
    public struct Factory: RouterFactory {
        public init() {}
    }
    
    public enum Table: String, RouterTable {
        
        case setTestStringToToolSingleton   = "RaRouter://Test/do/ToolSingleton/set"
        case clearTestStringToToolSingleton = "RaRouter://Test/do/ToolSingleton/clear"
        case asyncClearTestString           = "RaRouter://Test/do/asyncClearTestString"
        
        case getTestStringFromToolSingleton = "RaRouter://Test/get/ToolSingleton"
        case getErrorTypeValue              = "RaRouter://Test/get/errorType"
        case getSomeValue                   = "RaRouter://Test/get/some"
        case getDefaultValue                = "RaRouter://Test/get/default"
        case getDefaultValueWithSuccess     = "RaRouter://Test/get/default/success"
        case asyncGetSomeValue              = "RaRouter://Test/asyncGet/some"
    }
}

// MARK: - Router For Do

extension Router where Module == Test {
    
    static func testDoByToolSingleton(value: String) -> DoResult {
        return Router.do(.setTestStringToToolSingleton, param: value)
    }
    
    static func testDoByClearToolSingleton() -> DoResult {
        return Router.do(.clearTestStringToToolSingleton)
    }
    
    static func testDoByAsyncClearTestString(callback: @escaping DoResultCallback) {
        Router.do(.asyncClearTestString, callback: callback)
    }
}

// MARK: - Router For Get

extension Router where Module == Test {
    
    static func getStringFromToolSingleton() -> GetResult<String> {
        return Router.get(of: String.self, from: .getTestStringFromToolSingleton)
    }
    
    static func getErrorTypeValue() -> GetResult<String> {
        return Router.get(of: String.self, from: .getErrorTypeValue)
    }
    
    static func getSomeValue(from singleton: ToolSingleto) -> GetResult<String> {
        return Router.get(of: String.self, from: .getSomeValue, param: singleton)
    }
    
    static func getDefaultValue() -> GetResult<String> {
        return Router.get(of: String.self, from: .getDefaultValue)
    }
    
    static func getDefaultValueWithSuccess() -> GetResult<String> {
        return Router.get(of: String.self, from: .getDefaultValueWithSuccess)
    }
    
    static func delayedGetSomeValue(from singleton: ToolSingleton, callback: @escaping (GetResult<String>) -> Void) {
        Router.get(of: String.self, from: .asyncGetSomeValue, param: singleton, callback: callback)
    }
}
