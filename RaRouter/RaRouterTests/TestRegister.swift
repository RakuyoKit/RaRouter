//
//  TestRegister.swift
//  RaRouterTests
//
//  Created by MBCore on 2020/4/26.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

@testable import RaRouter

extension Test.Factory: FactoryMediatorProtocol {
    
    public var source: FactoryProtocol { RealFactory() }
    
    private struct RealFactory: FactoryProtocol {
        
        lazy var doHandlerFactories: [String : DoHandlerFactory]? = [
            
            Test.Table.setTestStringToToolSingleton.rawValue : { (url, value) -> DoResult in
                
                guard let param = value as? String else {
                    return .failure(.notHandler(url: url))
                }
                
                ToolSingleton.shared.value = param
                
                return .success(())
            },
            
            Test.Table.clearTestStringToToolSingleton.rawValue : { (url, value) -> DoResult in
                ToolSingleton.shared.clearedValue = nil
                return .success(())
            }
        ]
        
        lazy var asynDoHandlerFactories: [String : AsynDoHandlerFactory]? = [
            
            Test.Table.delayedClearTestString.rawValue : { (url, value, callback: @escaping DoResultCallback) in
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    ToolSingleton.shared.clearedValue = nil
                    callback(.success(()))
                }
            }
        ]
        
        lazy var getHandlerFactories: [String : GetHandlerFactory]? = [
            
            Test.Table.getTestStringFromToolSingleton.rawValue : { (url, value) -> GetResult<AnyResult> in
                return .success(ToolSingleton.shared.value as Any)
            },
            
            Test.Table.getErrorTypeValue.rawValue : { (url, value) -> GetResult<AnyResult> in
                return .success(ToolSingleton.shared.numberForGetErrorTypeValue)
            },
            
            Test.Table.getSomeValue.rawValue : { (url, value) -> GetResult<AnyResult> in
                
                guard let param = value as? ToolSingleton else {
                    return .failure(.parameterError(url: url, parameter: value))
                }
                
                return .success(param.realValue)
            },
            
            Test.Table.getDefaultValueWithSuccess.rawValue : { (url, value) -> GetResult<AnyResult> in
                return .success(ToolSingleton.shared.defaultValue)
            }
        ]
        
        lazy var asynGetHandlerFactories: [String : AsynGetHandlerFactory]? = [
            
            Test.Table.asyncGetSomeValue.rawValue : { (url, value, callback: @escaping GetResultCallback) in
                
                guard let param = value as? ToolSingleton else {
                    callback(.failure(.parameterError(url: url, parameter: value)))
                    return
                }
                
                DispatchQueue.main.async {
                    callback(.success(param.realValue))
                }
            }
        ]
    }
}
