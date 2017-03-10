//
//  CollectionViewCell.swift
//  AListViewController
//
//  Created by Arnaud Dorgans on 03/10/2017.
//  Copyright © 2017 Arnaud Dorgans. All rights reserved.
//

import UIKit
import PureLayout
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 4
        self.contentView.backgroundColor = UIColor.lightGray
        
        imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(imageView)
        imageView.autoPinEdgesToSuperviewEdges()
    }
    
    func update(withShot shot: DribbbleShot) {
        imageView.sd_setImage(with: shot.image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
