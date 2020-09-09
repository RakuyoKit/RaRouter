//
//  RaRouterTests.swift
//  RaRouterTests
//
//  Created by MBCore on 2020/4/26.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import XCTest

@testable import RaRouter

class RaRouterTests: XCTestCase {
    
    let string = "Result"
    
    override func setUpWithError() throws {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

// MARK: - Test For Do

extension RaRouterTests {
    
    func testDoWithParam() throws {
        
        switch Router<Test>.testDoByToolSingleton(value: string) {
        
        case .success(()):
            try testGetWithoutParam()
            
        case .failure(let error):
            XCTFail("do failure: \(error)")
        }
    }
    
    func testDoWithoutParam() throws {
        
        switch Router<Test>.testDoByClearToolSingleton() {
        
        case .success(()):
            
            let clearedValue = ToolSingleton.shared.clearedValue
            
            XCTAssertNil(clearedValue, "failure, Singleton value is: \(String(describing: clearedValue))")
            
        case .failure(let error):
            XCTFail("do failure: \(error)")
        }
    }
    
    func testDoWithAsyn() throws {
        
        Router<Test>.testDoByAsyncClearTestString { (result) in
            
            switch result {
                
                case .success(()):
                    
                    let clearedValue = ToolSingleton.shared.clearedValue
                    
                    XCTAssertNil(clearedValue, "failure, Singleton value is: \(String(describing: clearedValue))")
                    
                case .failure(let error):
                    XCTFail("do failure: \(error)")
            }
        }
    }
    
    func testDoWithNotHandler() throws {
        
        let url = "not register router url"
        
        switch Router<Test>.do(Test.Table(url)) {
            
        case .success(()):
            XCTFail("failure, Should not succeed")
            
        case .failure(let error):
            XCTAssert(error == .tableNil, "Other errors: \(error)")
        }
    }
}

// MARK: - Test For Get

extension RaRouterTests {

    func testGetWithoutParam() throws {
        
        let getResult = Router<Test>.getStringFromToolSingleton()
        
        switch getResult {
        case .success(let resultValue):
            XCTAssert(resultValue == string, "failure, Singleton value is: \(String(describing: resultValue))")
            
        case .failure(let error):
            XCTFail("get failure: \(error)")
        }
    }
    
    func testGetWithNotHandler() throws {
        
        let url = "not register router url"
        
        switch Router<Test>.get(of: Any.self, from: Test.Table(url)) {
            
        case .success(let value):
            XCTFail("failure, Should not succeed, value: \(value)")
            
        case .failure(let error):
            XCTAssert(error == .tableNil, "Other errors: \(error)")
        }
    }
    
    func testGetWithConvertTypeFailed() throws {
        
        switch Router<Test>.getErrorTypeValue() {
            
        case .success(let value):
            XCTFail("failure, Should not succeed, value: \(value)")
            
        case .failure(let error):
            
            let url = Test.Table.getErrorTypeValue.rawValue
            
            XCTAssert(error == .convertTypeFailed(url: url), "Other errors: \(error)")
        }
    }
    
    func testGetWithParamError() throws {
        
        switch Router<Test>.getSomeValue(from: ToolSingleto.shared) {
            
        case .success(let value):
            XCTFail("failure, Should not succeed, value: \(value)")
            
        case .failure(let error):
            
            let url = Test.Table.getSomeValue.rawValue
            let param = "Meaningless parameters, anything can be passed"
            
            XCTAssert(error == .parameterError(url: url, parameter: param), "Other errors: \(error)")
        }
    }
    
    func testGetDefaultValue() throws {
        
        let defaultValue = "Default Value"
        
        // unregistered
        let value = Router<Test>.getDefaultValue().get(default: defaultValue)
        
        XCTAssert(defaultValue == value, "\(value)")
    }
    
    func testGetDefaultValueWithSuccess() throws {
        
        let defaultValue = "Default Value"
        
        // unregistered
        let value = Router<Test>.getDefaultValueWithSuccess().get(default: defaultValue)
        
        XCTAssert(value == ToolSingleton.shared.defaultValue, "\(value)")
    }
    
    func testGetWithAsyn() throws {
        
        Router<Test>.delayedGetSomeValue(from: ToolSingleton.shared) { (result) in
            
            switch result {
                
            case .success(let value):
                XCTAssert(value == ToolSingleton.shared.realValue, "\(value)")
                
            case .failure(let error):
                XCTFail("Should not execute errors, Error: \(error)")
            }
        }
    }
}

// MARK: - Test For Error

extension RaRouterTests {
    
    func testErrorEqual() {
        XCTAssertFalse(RouterError.notHandler(url: "")  == RouterError.convertTypeFailed(url: ""))
        XCTAssertFalse(RouterError.notHandler(url: "a") == RouterError.notHandler(url: "b"))
        XCTAssertFalse(RouterError.notHandler(url: "b") == RouterError.parameterError(url: "c", parameter: nil))
        XCTAssertFalse(RouterError.controllerNil(url: "d", parameter: nil, message: "ms") ==
                       RouterError.controllerNil(url: "d", parameter: nil, message: "msg"))
    }
}

// MARK: - Test For Global

extension RaRouterTests {
    
    func testGlobal() {
        XCTAssertNotNil(Global.Table.none.rawValue, "url should not be nil")
    }
}
