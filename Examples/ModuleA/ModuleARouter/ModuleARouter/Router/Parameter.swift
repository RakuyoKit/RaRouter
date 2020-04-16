//
//  Parameter.swift
//  ModuleARouter
//
//  Created by Rakuyo on 2020/4/16.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import UIKit

public struct SectionDataSource {
    
    public init(title: String, dataSource: [DataSource]) {
        self.title = title
        self.dataSource = dataSource
    }
    
    public let title: String
    
    public let dataSource: [DataSource]
}

public struct DataSource {
    
    public init(title: String, action: @escaping (IndexPath) -> (UIViewController?, Bool)) {
        self.title = title
        self.action = action
    }
    
    public let title: String
    
    /// Execute on click
    ///
    /// Returns the controller to be displayed and whether it is displayed in `push` mode
    public let action: (IndexPath) -> (UIViewController?, Bool)
}
