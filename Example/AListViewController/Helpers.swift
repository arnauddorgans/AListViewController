//
//  Helpers.swift
//  AListViewController
//
//  Created by Arnaud Dorgans on 03/10/2017.
//  Copyright © 2017 Arnaud Dorgans. All rights reserved.
//

import UIKit

extension UITableView {
    func scrollToBottom() {
        let section = self.numberOfSections - 1
        let index = IndexPath(row: self.numberOfRows(inSection: section) - 1, section: section)
        self.scrollToRow(at: index, at: .bottom, animated: true)
    }
}

