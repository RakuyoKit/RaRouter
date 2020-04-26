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
    
    override func setUpWithError() throws {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        Router<Modules>.initialize()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

extension RaRouterTests {
    
    func testDoAndGet() throws {
        
        let value = "Result"
        
        let result = Router<Test>.testDoByToolSingleton(value: value)
        
        switch result {
        case .success(()):
            
            let getResult = Router<Test>.getStringFromToolSingleton()
            
            switch getResult {
            case .success(let resultValue):
                XCTAssert(resultValue == value, "failure, Singleton value is: \(String(describing: resultValue))")
                
            case .failure(let error):
                XCTFail("get failure: \(error)")
            }
            
        case .failure(let error):
            XCTFail("do failure: \(error)")
        }
    }
}
