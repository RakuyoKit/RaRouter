//
//  ViewController.swift
//  Examples
//
//  Created by Rakuyo on 2020/4/14.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import UIKit

import RaRouter
import ExamplesRouter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for `viewController`
        print(String(describing: try? Router<ModuleA>.create()))
        
        // for `do`
        try? Router<ModuleA>.doSomething(start: Date(), end: Date())
        
        // for `getResult`
        print(String(describing: try? Router<ModuleA>.calculateFrame(with: 375)))
    }
}

