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
        self.loadMoreEnabled = true
        
        self.configureCellIdentifier = { _, object in
            return CellIdentifier.default.rawValue
        }
        self.configureCell = { _,object,cell in
            let cell = cell as! CollectionViewCell
            cell.update(withShot: object as! DribbbleShot)
            return cell
        }
        self.fetchSourceObjects = { completion in
            DribbbleShot.get(atPage: self.currentPage, completion: { (success, shot, reachEnd) in
                self.currentPage += 1
                completion([shot], !success || reachEnd)
            })
        }
        self.didSelectCell = { indexPath,_,_ in
            self.deleteRow(withIndex: indexPath)
        }
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let object = self.object(atIndexPath: indexPath) as! DribbbleShot
        let rowByLine = CGFloat(self.rowByLine)
        let width = floor((self.view.frame.width - margin * (rowByLine + 1)) / rowByLine)
        let height = floor(width * object.ratio)
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
}
