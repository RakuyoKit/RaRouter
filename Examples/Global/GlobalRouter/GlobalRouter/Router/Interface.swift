//
//  Interface.swift
//  GlobalRouter
//
//  Created by Rakuyo on 2020/10/9.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import RaRouter

public enum GlobalDemo: ModuleRouter {
    
    @objc(GlobalDemoFactory)
    public final class Factory: NSObject, RouterFactory { }
    
    public enum Table: String, RouterTable {
        
        case router = "Demo://GlobalDemo/cannotBeExecutedDirectly"
    }
}
