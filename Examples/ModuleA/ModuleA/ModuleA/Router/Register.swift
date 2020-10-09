//
//  Register.swift
//  ModuleA
//
//  Created by Rakuyo on 2020/4/15.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import RaRouter
import ModuleARouter

extension ModuleA.Factory: FactoryMediator {

    public var source: RouterFactory { RealFactory() }

    fileprivate struct RealFactory: RouterFactory {
        
        lazy var doHandlerFactories: [String : DoHandlerFactory]? = [
            
            ModuleA.Table.print.rawValue : { (url, value) in
                print(value ?? "nil")
                return .success(())
            },
            
            ModuleA.Table.requestPush.rawValue : { (url, value) in
                print("Will request push permission.")
                UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { _, _ in }
                return .success(())
            }
        ]
        
        lazy var getHandlerFactories: [String : GetHandlerFactory]? = [
            
            ModuleA.Table.dataSource.rawValue : { (url, value) in
                return .success(ModuleA.Factory.RealFactory.dataSource)
            }
        ]
        
        var viewControllerHandlerFactories: [String : ViewControllerHandlerFactory]? = [
            
            ModuleA.Table.alert.rawValue : { (url, value) in
                
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
            },
            
            ModuleA.Table.detectMemoryLeaks.rawValue : { (url, value) in
                
                let controller = DetectMemoryLeaksViewController()
                
                return .success(controller)
            }
        ]
    }
}

private extension ModuleA.Factory.RealFactory {
    
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
                },
                
                DataSource(title: "Detect memory leaks") { _ in
                    
                    let controller = try? Router<ModuleA>.createDetectMemoryLeaks().get()
                    
                    return (controller, true)
                }
            ]),
            
            SectionDataSource(title: "Global", dataSource: [
                DataSource(title: "Perform routing via `Global`") { _ in
                    _ = Router<Global>.do("Demo://GlobalDemo/cannotBeExecutedDirectly")
                    return (nil, false)
                }
            ]),
        ]
    }
}
