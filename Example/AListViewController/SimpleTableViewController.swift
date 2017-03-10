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
    
    let menu = ["TableView Exemple","CollectionView Exemple"]
    let storyboardID = ["TableViewController","CollectionViewController"]
    
    override func customizeTableView(_ tableView: UITableView) {
        self.registerCellClass(UITableViewCell.self, withIdentifier: CellIdentifier.default.rawValue)
    }
    
    override func viewDidLoad() {
        self.configureCellIdentifier = { _, object in
            return CellIdentifier.default.rawValue
        }
        self.configureCell = { _,object,cell in
            cell.textLabel?.text = object as? String
            cell.selectionStyle = .none
            return cell
        }
        self.fetchSourceObjects = { completion in
            completion([self.menu], true, false)
        }
        self.didSelectCell = { indexPath,_,_ in
            let controller = self.storyboard!.instantiateViewController(withIdentifier: self.storyboardID[indexPath.row])
            self.navigationController?.pushViewController(controller, animated: true)
        }
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Examples"
    }
}

