//
//  EventTypePicker.swift
//  SocialTwist
//
//  Created by Marcel  on 1/27/18.
//  Copyright © 2018 Marcel . All rights reserved.
//

import UIKit

class EventTypePicker: UIView {

    private var collectionView: UICollectionView!
    public var completionHandler: ((String)->Void)?
    
    // MARK: - Constants
    
    let reuseIndentifier = "eventTypeCell"
    let images = [#imageLiteral(resourceName: "Eating"), #imageLiteral(resourceName: "Sport"), #imageLiteral(resourceName: "Coffee"), #imageLiteral(resourceName: "Drink"), #imageLiteral(resourceName: "Thinking"), #imageLiteral(resourceName: "Traveling"), #imageLiteral(resourceName: "Watching"), #imageLiteral(resourceName: "Celebrating"), #imageLiteral(resourceName: "Celebrating1"), #imageLiteral(resourceName: "Meeting"), #imageLiteral(resourceName: "Listen"), #imageLiteral(resourceName: "Shopping"), #imageLiteral(resourceName: "Reading"), #imageLiteral(resourceName: "Supporting"), #imageLiteral(resourceName: "Attending"), #imageLiteral(resourceName: "Making"), #imageLiteral(resourceName: "Sad"), #imageLiteral(resourceName: "Happy"), #imageLiteral(resourceName: "Loved"), #imageLiteral(resourceName: "Amused"), #imageLiteral(resourceName: "Wonderful"), #imageLiteral(resourceName: "Energized"), #imageLiteral(resourceName: "Alone"), #imageLiteral(resourceName: "Hungry")]
    let imageNames = ["Eating", "Sport", "Coffe", "Drink", "Thinking", "Traveling", "Watching", "Celebrating",
                      "Celebrating1", "Meeting", "Listen", "Shopping", "Reading", "Supporting", "Attending", "Making",
                      "Sad", "Happy", "Loved", "Amused", "Wonderful", "Energized", "Alone", "Hungry"]
    let title = ["Eating", "Sport", "Coffe", "Drink", "Thinking", "Traveling", "Watching", "Celebrating",
                 "Celebrating", "Meeting", "Listen", "Shopping", "Reading", "Supporting", "Attending", "Making",
                 "Sad", "Happy", "Loved", "Amused", "Wonderful", "Energized", "Alone", "Hungry"];
    
    /*
     let images = [#imageLiteral(resourceName: "Eating"), #imageLiteral(resourceName: "Sport"), #imageLiteral(resourceName: "Coffee"), #imageLiteral(resourceName: "Drink"), #imageLiteral(resourceName: "Thinking"), #imageLiteral(resourceName: "Traveling"), #imageLiteral(resourceName: "Watching"), #imageLiteral(resourceName: "Celebrating"), #imageLiteral(resourceName: "Celebrating1"), #imageLiteral(resourceName: "Meeting"), #imageLiteral(resourceName: "Listen"), #imageLiteral(resourceName: "Shopping"), #imageLiteral(resourceName: "Reading"), #imageLiteral(resourceName: "Supporting"), #imageLiteral(resourceName: "Attending"), #imageLiteral(resourceName: "Making"), #imageLiteral(resourceName: "Sad"), #imageLiteral(resourceName: "Happy"), #imageLiteral(resourceName: "Loved"), #imageLiteral(resourceName: "Amused"), #imageLiteral(resourceName: "Wonderful"), #imageLiteral(resourceName: "Energized"), #imageLiteral(resourceName: "Alone"), #imageLiteral(resourceName: "Hungry"),  #imageLiteral(resourceName: "Sport"), #imageLiteral(resourceName: "Coffee"), #imageLiteral(resourceName: "Drink"), #imageLiteral(resourceName: "Thinking"), #imageLiteral(resourceName: "Traveling"), #imageLiteral(resourceName: "Watching"), #imageLiteral(resourceName: "Celebrating"), #imageLiteral(resourceName: "Celebrating1"), #imageLiteral(resourceName: "Meeting"), #imageLiteral(resourceName: "Listen"), #imageLiteral(resourceName: "Shopping"), #imageLiteral(resourceName: "Reading"), #imageLiteral(resourceName: "Supporting"), #imageLiteral(resourceName: "Attending"), #imageLiteral(resourceName: "Making"), #imageLiteral(resourceName: "Sad"), #imageLiteral(resourceName: "Happy"), #imageLiteral(resourceName: "Loved"), #imageLiteral(resourceName: "Amused"), #imageLiteral(resourceName: "Wonderful"), #imageLiteral(resourceName: "Energized"), #imageLiteral(resourceName: "Alone"), #imageLiteral(resourceName: "Hungry")]
     
     let title = ["Eating", "Sport", "Coffe", "Drink", "Thinking", "Traveling", "Watching", "Celebrating",
     "Celebrating", "Meeting", "Listen", "Shopping", "Reading", "Supporting", "Attending", "Making",
     "Sad", "Happy", "Loved", "Amused", "Wonderful", "Energized", "Alone", "Hungry", "Sport", "Coffe", "Drink", "Thinking", "Traveling", "Watching", "Celebrating",
     "Celebrating", "Meeting", "Listen", "Shopping", "Reading", "Supporting", "Attending", "Making",
     "Sad", "Happy", "Loved", "Amused", "Wonderful", "Energized", "Alone", "Hungry"];
     */
    
    // MARK: - Setup
    
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 20, height: 230)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 8)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(EventTypeCell.self, forCellWithReuseIdentifier: reuseIndentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        
        addSubview(collectionView)
    }
    
    // Keyboard
    
    open class func show() -> EventTypePicker {
        let eventKeyboard = EventTypePicker()
        eventKeyboard.setupCollectionView()
        
        return eventKeyboard
    }
}

// MARK: - CollectionView Delegate, Data Source

extension EventTypePicker: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIndentifier, for: indexPath) as! EventTypeCell
        
        cell.itemImageView.image = images[indexPath.row]
        cell.itemTitle.text = title[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        completionHandler?(imageNames[indexPath.row])
    }
    
    // MARK: - Collection View Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 50)
    }
}



