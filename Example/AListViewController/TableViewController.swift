//
//  TableViewController.swift
//  AListViewController
//
//  Created by Arnaud Dorgans on 03/10/2017.
//  Copyright © 2017 Arnaud Dorgans. All rights reserved.
//

import UIKit
import AListViewController

class TableViewController: ATableViewController {
    
    enum CellIdentifier: String {
        case left = "left"
        case right = "right"
        case emoji = "emoji"
    }
    
    @IBAction func addHi() {
        self.say("Hi !")
    }
    
    @IBAction func addUnicorn() {
        self.say("🦄")
    }
    
    @IBAction func addChat() {
        self.insertSection(withObject: Message.demoChat)
        self.tableView.scrollToBottom()
    }
    
    func say(_ string: String) {
        self.insertRow(withObject: Message(text: string,isOwn: true))
        self.tableView.scrollToBottom()
    }
    
    override func customizeTableView(_ tableView: UITableView) {
        self.registerCellClass(EmojiCell.self, withIdentifier: CellIdentifier.emoji.rawValue)
    }
    
    override func viewDidLoad() {
        self.rowAnimation = (.right,.top,.automatic)
        self.pullToRefreshEnabled = true
        
        self.configure(cellIdentifier: { _, object -> String in
            
            let message = object as! Message
            let identifier = message.isOwn ? CellIdentifier.right.rawValue : CellIdentifier.left.rawValue
            return message.isEmoji ? CellIdentifier.emoji.rawValue : identifier
            
        }, cellUpdate: { _, object, cell in
            
            let cell = cell as! TableViewCell
            cell.update(withMessage: object as! Message)
            
        }, sourceObjects: { (completion) in
            
            completion([Message.demoChat], true)
            
        }, didSelectCell: { [weak self] indexPath, _ in
            
            self?.deleteRow(withIndex: indexPath)
            
        })
        super.viewDidLoad()
    }
}

