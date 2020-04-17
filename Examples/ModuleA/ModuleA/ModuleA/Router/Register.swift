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
        
        router.register(for: .dataSource) { (url, value) -> GetResult<[SectionDataSource]> in
            return .success(dataSource)
        }
        
        router.register(for: .print) { (url, value) -> DoResult in
            print(value ?? "nil")
            return .success(())
        }
        
        router.register(for: .requestPush) { (url, value) -> DoResult in
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { _, _ in }
            return .success(())
        }
        
        router.register(for: .alert) { (url, value) -> ViewControllerResult in
            
            guard let parma = value as? (title: String?, message: String?) else {
                return .failure(.parameterError(url: url, parameter: value))
            }
            
            let alert = UIAlertController(
                title: parma.title,
                message: parma.message,
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "done", style: .default, handler: nil))
            
            return .success(alert) 
        }
    }
}

private extension ModuleARegister {
    
    static var dataSource: [SectionDataSource] {
        [
            SectionDataSource(title: "do", dataSource: [
                DataSource(title: "Print clicked index in the console") {
                    _ = Router<ModuleA>.print("Clicked on row \($0.row) of section \($0.section) 🤔")
                    return (nil, false)
                },
                
                DataSource(title: "Request push permission") { _ in
                    _ = Router<ModuleA>.requestPushPermission()
                    return (nil, false)
                }
            ]),
            
            SectionDataSource(title: "View Controller", dataSource: [
                DataSource(title: "Show alert") { _ in
                    
                    let controller = try? Router<ModuleA>.alert(
                        title: "ViewController Router",
                        message: "Hello ~ 😜"
                    ).get()
                    
                    return (controller, false)
                }
            ])
        ]
    }
}
