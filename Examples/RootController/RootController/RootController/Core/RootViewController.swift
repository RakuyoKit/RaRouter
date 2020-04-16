//
//  RootViewController.swift
//  RootController
//
//  Created by Rakuyo on 2020/4/16.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import UIKit

import RaRouter
import ModuleARouter

open class RootViewController: UITableViewController {
    
    private lazy var dataSource = (try? Router<ModuleA>.getDataSource()) ?? []
}

// MARK: - The life cycle

extension RootViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "RaRouter demo"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension RootViewController {
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dataSource = self.dataSource[indexPath.section].dataSource
        
        guard let controller = dataSource[indexPath.row].action(indexPath) else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension RootViewController {
    
    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].title
    }
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].dataSource.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let dataSource = self.dataSource[indexPath.section].dataSource
        
        cell.textLabel?.text = dataSource[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
