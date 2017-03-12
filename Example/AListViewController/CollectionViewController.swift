//
//  CollectionViewController.swift
//  AListViewController
//
//  Created by Arnaud Dorgans on 03/10/2017.
//  Copyright © 2017 Arnaud Dorgans. All rights reserved.
//

import UIKit
import AListViewController
import PureLayout

class CollectionViewController: ACollectionViewController {
    
    enum CellIdentifier: String {
        case `default` = "cell"
    }
    
    let startPage = 1
    var currentPage: Int = 0
    
    let rowByLine = 3
    let margin: CGFloat = 10
    
    override func refreshData(reload: Bool, immediately: Bool) {
        if reload {
            currentPage = startPage
        }
        super.refreshData(reload: reload, immediately: immediately)
    }
    
    override func customizeCollectionView(_ collectionView: UICollectionView) {
        self.registerCellClass(CollectionViewCell.self, withIdentifier: CellIdentifier.default.rawValue)
        
        collectionView.backgroundColor = .clear
        self.view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
    }

    override func viewDidLoad() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        self.pullToRefreshEnabled = true
        self.infiniteScrollingEnabled = true
        
        self.configure(cellIdentifier: { _ -> String in
            
            return CellIdentifier.default.rawValue
            
        }, cellUpdate: { _, object, cell in
            
            let cell = cell as! CollectionViewCell
            cell.update(withShot: object as! DribbbleShot)
            
        }, cellSize: { [weak self] _, object -> CGSize in
            if let _self = self {
                let object = object as! DribbbleShot
                let rowByLine = CGFloat(_self.rowByLine)
                let width = floor((_self.view.frame.width - _self.margin * (rowByLine + 1)) / rowByLine)
                let height = floor(width * object.heightRatio)
                let size = CGSize(width: width, height: height)
                return size
            }
            return .zero
            
        }, minimumSpacing: { [weak self] section in
            
            return CGSize(width: self?.margin ?? 0, height: self?.margin ?? 0)
            
        }, sourceObjects: { [weak self] completion in
            if let _self = self {
                DribbbleShot.get(atPage: _self.currentPage, completion: { (success, shot, reachEnd) in
                    _self.currentPage += 1
                    completion([shot], !success || reachEnd)
                })
            }
        }, didSelectCell: { [weak self] indexPath, object in
            
            self?.deleteRow(withIndex: indexPath)
            
        })
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
}
