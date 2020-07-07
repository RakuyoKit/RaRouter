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
        
        case setTestStringToToolSingleton   = "RaRouter://test/do/ToolSingleton/set"
        case clearTestStringToToolSingleton = "RaRouter://test/do/ToolSingleton/clear"
        case delayedClearTestString         = "RaRouter://test/do/delayedClearTestString"
        
        case getTestStringFromToolSingleton = "RaRouter://test/get/ToolSingleton"
        case getErrorTypeValue              = "RaRouter://test/get/errorType"
        case getSomeValue                   = "RaRouter://test/get/some"
        case getDefaultValue                = "RaRouter://test/get/default"
        case getDefaultValueWithSuccess     = "RaRouter://test/get/default/success"
        case asyncGetSomeValue              = "RaRouter://test/asyncGet/some"
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
    
    static func testDoByDelayedClearTestString(callback: @escaping DoResultCallback) {
        Router.do(.delayedClearTestString, callback: callback)
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
