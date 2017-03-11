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
    
    let chat = [Message(text:"Wyd?",isOwn:true),
                Message(text:"Chillin at home. You?",isOwn:false),
                Message(text:"Nothing. Wanna hang out?",isOwn:true),
                Message(text:"Sure where do you wanna meet?",isOwn:false),
                Message(text:"Outside campus. Let's say 8?",isOwn:true),
                Message(text:"Sounds great",isOwn:false),
                Message(text:"See ya",isOwn:true)]
    
    @IBAction func addHi() {
        self.say("Hi !")
    }
    
    @IBAction func addUnicorn() {
        self.say("🦄")
    }
    
    @IBAction func addChat() {
        self.insertSection(withObject: self.chat)
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
        self.pullToRefreshEnabled = true
        self.configureCellIdentifier = { _, object in
            let message = object as! Message
            let identifier = message.isOwn ? CellIdentifier.right.rawValue : CellIdentifier.left.rawValue
            return message.isEmoji ? CellIdentifier.emoji.rawValue : identifier
        }
        self.configureCell = { _,object,cell in
            let cell = cell as! TableViewCell
            cell.update(withMessage: object as! Message)
            return cell
        }
        self.fetchSourceObjects = { completion in
            completion([self.chat], true)
        }
        self.didSelectCell = { indexPath,_,_ in
            self.deleteRow(withIndex: indexPath)
        }
        super.viewDidLoad()
    }
}

