//
//  InviteHeader.swift
//  SocialTwist
//
//  Created by Marcel  on 1/1/18.
//  Copyright © 2018 Marcel . All rights reserved.
//

import UIKit
import AlignedCollectionViewFlowLayout

// MARK: - Protocols
protocol InviteHeaderDelegate: class {
    func didTapDeleteButton()
}


class InviteHeader: UIView {
    
    // MARK: - Properties
    
    weak var delegate: InviteHeaderDelegate?
    
    var collectionView: UICollectionView!
    var guests = [Friend]()
    var maxHeight: CGFloat = 108
    var height: CGFloat {
        if intrinsicContentSize.height < maxHeight{
            return intrinsicContentSize.height == 0 ? 10 : intrinsicContentSize.height
        } else {
            return maxHeight
        }
    }
    
    // MARK: - Constants
    
    let reuseIndentifier = "collectionViewCell"
    
    // MARK: - Object life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //This is required to make view grow vertically
        autoresizingMask = .flexibleHeight
        backgroundColor = UIColor.clear
        
        setupCollectionView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupCollectionView() {
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .center)
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.register(GuestCell.self, forCellWithReuseIdentifier: reuseIndentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        let views = ["v0": collectionView!]
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: [], metrics: nil, views: views))
    }
    
    // MARK: - Layout
    
    override var intrinsicContentSize: CGSize {
        return collectionView.collectionViewLayout.collectionViewContentSize
    }
    
    // MARK: - CollectionView action's
    
    func insertNewGuest(guest: Friend) {
        if !guests.contains(where: {$0.id == guest.id}) {
            guests.append(guest)
            let row = guests.count - 1
            let indexPath = IndexPath(row: row, section: 0)
            collectionView.insertItems(at: [indexPath])
        }
        
        // Scroll to bottom
        if intrinsicContentSize.height > maxHeight {
            scrollToBottom()
        }
        
        collectionView.backgroundColor = UIColor.TwistPalette.FlatGray
    }
    
    func scrollToBottom() {
        let lastItemIndex = IndexPath(item: guests.count - 1, section: 0)
        collectionView.scrollToItem(at: lastItemIndex, at: .centeredVertically, animated: true);
    }
}


// MARK: - CollectionView Cell Delegate

extension InviteHeader: GuestCellDelegate {
    func didTapDeleteButton(_ sender: UIButton, _ event: UIEvent) {
        let touches = event.allTouches
        let touch = touches?.first
        let point = touch?.location(in: collectionView)
        let indexPath = collectionView.indexPathForItem(at: point!)
        //        print("Touched index path point \(indexPath)")
        
        guests.remove(at: (indexPath?.row)!)
        collectionView.deleteItems(at: [indexPath!])
        
        // Set clear color if collection view is empty
        if collectionView.numberOfItems(inSection: 0) == 0 {
            collectionView.backgroundColor = UIColor.clear
        }
        
        delegate?.didTapDeleteButton()
    }
}


// MARK: - CollectionView Delegate, Data Source

extension InviteHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIndentifier, for: indexPath) as! GuestCell
        
        let guest = guests[indexPath.row]
        cell.label.text = guest.firstName + guest.lastName
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - Collection View Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let string = guests[indexPath.row].firstName + guests[indexPath.row].lastName
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 540, height: 30))
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = string
        

        let size = label.intrinsicContentSize
        let currentWidth = size.width + 35
//        print("Label size \(size)")
//        print("Screen size \(screenBounds.width)")
//        print("Collection size \(collectionView.frame.size)")
//        print("Layout size \(collectionView.collectionViewLayout.collectionViewContentSize.height)")
        
        if currentWidth > collectionView.frame.size.width - 5 {
           return CGSize(width: collectionView.frame.size.width - 2, height: size.height + 8)
        } else {
           return CGSize(width: currentWidth, height: size.height + 8)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
}










// MARK: - CollectionView Cell

// MARK: - Protocols

protocol GuestCellDelegate: class {
    func didTapDeleteButton(_ sender: UIButton, _ event: UIEvent)
}

class GuestCell: UICollectionViewCell {
    
    weak var delegate: GuestCellDelegate?
    
    // MARK: - Constants
    
    let label = UILabel()
    let deleteButton = UIButton()
    
    // MARK: - Object life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        
        // Build view hierarchy
        addSubview(label)
        addSubview(deleteButton)
        
        setupLabel()
        setupDeleteButton()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupLabel() {
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        label.font = UIFont.systemFont(ofSize: 13)
        label.backgroundColor = UIColor.clear
    }
    
    private func setupDeleteButton() {
        deleteButton.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
        deleteButton.backgroundColor = UIColor.clear
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton(_:_:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        let views = ["v0": label,
                     "v1": deleteButton]
        // max width of label is screen width - left, right padding(8), button size(26), and left, right superview padding(5)
        let metrics = ["labelMaxWidth": UIScreen.main.bounds.width - 16 - 26 - 10]
        
        label.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0(<=labelMaxWidth)][v1(>=25,<=26)]|", options: [], metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v1]|", options: [], metrics: nil, views: views))
    }
    
    // MARK: - Action's
    
    @objc func didTapDeleteButton(_ sender: UIButton, _ event: UIEvent) {
        delegate?.didTapDeleteButton(sender, event)
    }
}
