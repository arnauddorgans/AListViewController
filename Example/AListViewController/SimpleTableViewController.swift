//
//  SimpleTableViewController.swift
//  AListViewController
//
//  Created by Arnaud Dorgans on 03/10/2017.
//  Copyright (c) 2017 Arnaud Dorgans. All rights reserved.
//

import UIKit
import AListViewController

class SimpleTableViewController: ATableViewController {
    
    enum CellIdentifier: String {
        case `default` = "cell"
    }
    
    let menu = [("TableView Exemple","TableViewController"),
                ("CollectionView Exemple","CollectionViewController")]
    
    override func customizeTableView(_ tableView: UITableView) {
        self.registerCellClass(UITableViewCell.self, withIdentifier: CellIdentifier.default.rawValue)
    }
    
    override func viewDidLoad() {
        self.rowAnimationEnabled = false
        
        self.configure(cellIdentifier: { _ -> String in
            
            return CellIdentifier.default.rawValue
            
        }, cellUpdate: { (_, object, cell) in
            
            cell.textLabel?.text = (object as? (String,String))?.0
            cell.selectionStyle = .none
            
        }, sourceObjects: { (completion) in
            
            completion([self.menu], true)
            
        }, didSelectCell: { [weak self] (_, object) in
            
            if let _self = self {
                let controller = _self.storyboard!.instantiateViewController(withIdentifier: (object as! (String,String)).1)
                _self.navigationController?.pushViewController(controller, animated: true)
            }
            
        })
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Examples"
    }
}

