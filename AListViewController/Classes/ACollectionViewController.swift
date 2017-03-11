//
//  ACollectionViewController.swift
//
//  Created by Arnaud Dorgans on 03/08/2017.
//  Copyright © 2017 ATableViewController (https://github.com/Arnoymous/ATableViewController)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

open class ACollectionViewController: AListViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet open var collectionView: UICollectionView!
    public var configureCell: ((IndexPath,Any,UICollectionViewCell) -> UICollectionViewCell)!
    public var didSelectCell: ((IndexPath,Any,UICollectionViewCell?) -> Void)?
    
    open func customizeCollectionView(_ collectionView: UICollectionView) { }
    
    override func customizeScrollView(_ scrollView: UIScrollView) {
        self.customizeCollectionView(collectionView)
    }
    
    open override func viewDidLoad() {
        if let collectionView = collectionView {
            self.scrollView = collectionView
        } else {
            fatalError("collectionView need to be set before super.viewDidLoad()")
        }
        if configureCell == nil {
            fatalError("configureCell need to be set programatically before super.viewDidLoad()")
        }
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        #if ALISTVIEWCONTROLLER_PULL
        if (pullToRefreshEnabled || loadMoreEnabled) && !collectionView.alwaysBounceVertical {
            collectionView.alwaysBounceVertical = true
        }
        #endif
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(inSection: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectCell?(indexPath,object(atIndexPath: indexPath),collectionView.cellForItem(at: indexPath))
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier(atIndexPath: indexPath), for: indexPath)
        return configureCell(indexPath,object(atIndexPath: indexPath),cell)
    }
    
    deinit {
        self.collectionView = nil
        self.configureCell = nil
        self.didSelectCell = nil
    }
}
