//
//  Message.swift
//  AListViewController
//
//  Created by Arnaud Dorgans on 03/10/2017.
//  Copyright © 2017 Arnaud Dorgans. All rights reserved.
//

import UIKit
import SwiftEmoji

class Message {
    private (set) var text: String
    private (set) var isOwn: Bool
    private (set) var isEmoji: Bool
    
    init(text: String,isOwn: Bool) {
        self.text = text
        self.isOwn = isOwn
        self.isEmoji = Emoji.isPureEmojiString(text)
    }
    
    static let demoChat = [Message(text:"Wyd?",isOwn:true),
                           Message(text:"Chillin at home. You?",isOwn:false),
                           Message(text:"Nothing. Wanna hang out?",isOwn:true),
                           Message(text:"Sure where do you wanna meet?",isOwn:false),
                           Message(text:"Outside campus. Let's say 8?",isOwn:true),
                           Message(text:"Sounds great",isOwn:false),
                           Message(text:"See ya",isOwn:true)]
}
