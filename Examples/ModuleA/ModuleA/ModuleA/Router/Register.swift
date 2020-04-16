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
                    DataSource(title: "Print Test") { _ in
                        print("The first Test! 🤩")
                        return nil
                    }
                ])
            ]
        }
    }
}
