//
//  RouterTable.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/9/8.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// Used to manage the routing address provided by the module.
public protocol RouterTable {
    
    /// According to the content of the attribute to find the content to be executed in the factory.
    var url: String { get }
}

extension String: RouterTable {
    
    public var url: String { self }
}

/// You can manage the routing table by defining an `enum` of `String`.
///
/// E.g:
///
/// ```swift
/// enum Table: String, RouterTable {
///     case create = "RaRouter://Module/create"
/// }
/// ```
public extension RouterTable where Self: RawRepresentable, Self.RawValue == String {
    
    var url: String { rawValue }
    
    init?(_ value: String) {
        self.init(rawValue: value)
    }
}
