//
//  Interface.swift
//  ExamplesRouter
//
//  Created by Rakuyo on 2020/4/14.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import RaRouter

public enum ModuleA: ModuleRouter {
    
    public typealias Table = RouterTable
    
    public enum RouterTable: String, RouterTableProtocol {
        
        public var url: String { rawValue }
        
        case create         = "rakuyo://moduleA/create"
        case doSomething    = "rakuyo://moduleA/do/something"
        case calculateFrame = "rakuyo://moduleA/calculate/frame"
    }
}

public extension Router where Module == ModuleA {
    
    static func create() throws -> UIViewController {
        return try Router.viewController(.create)
    }

    static func doSomething(start: Date, end: Date) throws {
        try Router.do(.doSomething, param: (start, end))
    }

    static func calculateFrame(with screenWidth: CGFloat) throws -> CGRect? {
        return try Router.getResult(.calculateFrame, param: screenWidth) as? CGRect
    }
}
