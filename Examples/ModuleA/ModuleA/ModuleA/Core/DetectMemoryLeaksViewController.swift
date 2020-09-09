//
//  DetectMemoryLeaksViewController.swift
//  ModuleA
//
//  Created by Rakuyo on 2020/9/9.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import UIKit

class DetectMemoryLeaksViewController: UIViewController {
    
    private lazy var tipsLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detect memory leaks"
        
        view.backgroundColor = .darkGray
        
        tipsLabel.text = "Return to the previous page, if the program does not crash after 2 seconds, the memory is not leaked."
        tipsLabel.textColor = .white
        tipsLabel.numberOfLines = 0
        
        view.addSubview(tipsLabel)
        
        tipsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let yConstraint = NSLayoutConstraint(item: tipsLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        let xConstraint = NSLayoutConstraint(item: tipsLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        
        let leftConstraint = NSLayoutConstraint(item: tipsLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 30)
        let rightConstraint = NSLayoutConstraint(item: tipsLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -30)
        
        view.addConstraints([yConstraint, xConstraint, leftConstraint, rightConstraint])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        checkDeallocation()
    }
}

private extension DetectMemoryLeaksViewController {
    
    func checkDeallocation(afterDelay delay: Int = 2) {
        
        guard tabBarController == nil else { return }
        
        if (isMovingFromParent && navigationController?.viewControllers.first != self)
            || rootParentViewController.isBeingDismissed {
            
            let value = type(of: self)
            
            let disappearanceSource: String = isMovingFromParent ? "removed from its parent"
                : "dismissed"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) { [weak self] in
                assert(self == nil, "\(value) not deallocated after being \(disappearanceSource)")
            }
        }
    }
    
    var rootParentViewController: UIViewController {
        var root = self as UIViewController
        while let parent = root.parent {
            root = parent
        }
        return root
    }
}
