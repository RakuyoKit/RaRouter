//
//  Register.swift
//  ModuleA
//
//  Created by Rakuyo on 2020/4/15.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import RaRouter
import ModuleARouter

private class ModuleARegister: RouterRegister {
    
    static func register() {
        
        let router = Router<ModuleA>.self
        
        router.register(for: .dataSource) { (url, value) throws -> [SectionDataSource] in
            
            return [
                
                SectionDataSource(title: "do", dataSource: [
                    DataSource(title: "Print clicked index in the console") {
                        try? Router<ModuleA>.print("Clicked on row \($0.row) of section \($0.section) 🤔")
                        return (nil, false)
                    }
                ]),
                
                SectionDataSource(title: "View Controller", dataSource: [
                    DataSource(title: "Show alert") { _ in
                        
                        let controller = try? Router<ModuleA>.alert(
                            title: "ViewController Router",
                            message: "Hello ~ 😜"
                        )
                        
                        return (controller, false)
                    }
                ])
            ]
        }
        
        router.register(for: .print) { (url, value) throws -> Void in
            print(value ?? "nil")
        }
        
        router.register(for: .alert) { (url, value) throws -> UIViewController in
            
            guard let parma = value as? (title: String?, message: String?) else {
                throw RouterError.parameterError(url: url, parameter: value)
            }
            
            let alert = UIAlertController(
                title: parma.title,
                message: parma.message,
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "done", style: .default, handler: nil))
            
            return alert
        }
    }
}
