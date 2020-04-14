//
//  Register.swift
//  Examples
//
//  Created by Rakuyo on 2020/4/14.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import RaRouter
import ExamplesRouter

// Following the `RouterRegister` protocol is the key
private class ModuleARegister: RouterRegister {
    
    static func register() {
        
        let router = Router<ModuleA>.self
        
        router.register(for: .create) { (url, value) throws -> UIViewController in
            return UIViewController()
        }

        router.register(for: .doSomething) { (url, value) throws -> Void in
            
            guard let param = value as? (start: Date, end: Date) else {
                throw RouterError.parameterError(url: url, parameter: value)
            }
        
            print("We are doing these things from \(param.start) to \(param.end)")
        }

        router.register(for: .calculateFrame) { (url, value) throws -> CGRect in
            
            guard let screenWidth = value as? CGFloat else {
                throw RouterError.parameterError(url: url, parameter: value)
            }

            return CGRect(x: 0, y: 0, width: screenWidth * 0.25, height: screenWidth)
        }
    }
}
