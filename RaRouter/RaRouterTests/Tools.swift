//
//  Tools.swift
//  RaRouterTests
//
//  Created by MBCore on 2020/4/26.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

class ToolSingleton {
    
    static let shared = ToolSingleton()
    
    /// Value to be set
    var value: String? = nil
    
    /// Value to be cleared
    var clearedValue: String? = "some value"
    
    /// For `getErrorTypeValue()` test
    var numberForGetErrorTypeValue = 1024
    
    /// The value that really needs to be read
    var realValue: String = "The value that really needs to be read"
    
    /// For `getDefaultValue`
    var defaultValue: String? = "Success Default Value"
}

// Only one letter "n" less than `ToolSingleton`
class ToolSingleto {
    
    static let shared = ToolSingleto()
}
