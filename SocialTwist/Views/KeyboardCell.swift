//
//  KeyboardCell.swift
//  SocialTwist
//
//  Created by Marcel  on 1/25/18.
//  Copyright © 2018 Marcel . All rights reserved.
//

import UIKit

class KeyboardCell: UICollectionViewCell {
    
    // MARK: -
    
    let itemImageView = UIImageView()
    let itemTitle = UILabel()
    
    
    // MARK: - Object life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(itemImageView)
        addSubview(itemTitle)
        
        setupItemImageView()
        setupItemTitle()
        setupConstraints()
        
//        layer.masksToBounds = true
//        layer.cornerRadius = 12
//        backgroundColor = UIColor.TwistPalertte.FlatGray
//        backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupItemImageView() {
        itemImageView.contentMode = .scaleAspectFit
    }
    
    func setupItemTitle() {
        itemTitle.minimumScaleFactor = 0.5
        itemTitle.numberOfLines = 1
        itemTitle.font = UIFont.boldSystemFont(ofSize: 10)
        itemTitle.textAlignment = .center
        itemTitle.textColor = UIColor.TwistPalette.DarkGray
    }
    
    func setupConstraints() {
        let views = ["title": itemTitle,
                     "image": itemImageView]
        
        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[image(20@20)]-12-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[title]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image]-6-[title(15)]-0-|", options: [], metrics: nil, views: views))
    }
    
}
