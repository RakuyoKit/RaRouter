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
    
    static let router = Router<Test>.self
    
    static func register() {
        
        registerDoRouter()
        registerGetRouter()
    }
}

// MARK: - Register For Do

extension TestRegister {
    
    static func registerDoRouter() {
        
        router.register(for: .setTestStringToToolSingleton) { (url, value) -> DoResult in

            guard let param = value as? String else {
                return .failure(.notHandler(url: url))
            }

            ToolSingleton.shared.value = param

            return .success(())
        }
        
        router.register(for: .clearTestStringToToolSingleton) { (url, value) -> DoResult in
            ToolSingleton.shared.clearedValue = nil
            return .success(())
        }
        
        router.register(for: .delayedClearTestString) { (url, value, callback: @escaping DoResultCallback) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                ToolSingleton.shared.clearedValue = nil
                callback(.success(()))
            }
        }
    }
}

// MARK: - Register For Get

extension TestRegister {
    
    static func registerGetRouter() {
        
        router.register(for: .getTestStringFromToolSingleton) { (url, value) -> GetResult<AnyResult> in
            return .success(ToolSingleton.shared.value as Any)
        }
        
        router.register(for: .getErrorTypeValue) { (url, value) -> GetResult<AnyResult> in
            return .success(ToolSingleton.shared.numberForGetErrorTypeValue)
        }
        
        router.register(for: .getSomeValue) { (url, value) -> GetResult<AnyResult> in
            
            guard let param = value as? ToolSingleton else {
                return .failure(.parameterError(url: url, parameter: value))
            }
            
            return .success(param.realValue)
        }
        
        router.register(for: .getDefaultValueWithSuccess) { (url, value) -> GetResult<AnyResult> in
            return .success(ToolSingleton.shared.defaultValue)
        }
        
        router.register(for: .asyncGetSomeValue) { (url, value, callback: @escaping GetResultCallback) in
            
            guard let param = value as? ToolSingleton else {
                callback(.failure(.parameterError(url: url, parameter: value)))
                return
            }
            
            DispatchQueue.main.async {
                callback(.success(param.realValue))
            }
        }
    }
}
