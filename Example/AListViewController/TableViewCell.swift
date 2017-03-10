//
//  TableViewCell.swift
//  AListViewController
//
//  Created by Arnaud Dorgans on 03/10/2017.
//  Copyright © 2017 Arnaud Dorgans. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    func update(withMessage message: Message) { }
}

class EmojiCell: TableViewCell {
    let label = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        label.font = UIFont.systemFont(ofSize: 50)
        self.contentView.addSubview(label)
    }
    
    override func update(withMessage message: Message) {
        label.text = message.text
        label.textAlignment = message.isOwn ? .right : .left
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame = self.contentView.bounds
        frame.origin.x = 7
        frame.size.width -= 2 * frame.origin.x
        label.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MessageCell: TableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bg: UIView!
    
    override func update(withMessage message: Message) {
        label.text = message.text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bg.layer.cornerRadius = bg.frame.height / 2
    }
}
