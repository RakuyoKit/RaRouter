//
//  RouterTable.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/9/8.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

public protocol RouterTable {
    
    var url: String { get }
}

extension String: RouterTable {
    
    public var url: String { self }
}

public extension RouterTable where Self: RawRepresentable, Self.RawValue == String {
    
    var url: String { rawValue }
    
    init?(_ value: String) {
        self.init(rawValue: value)
    }
}
