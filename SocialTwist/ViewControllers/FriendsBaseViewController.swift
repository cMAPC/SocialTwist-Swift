//
//  FriendsBaseViewController.swift
//  SocialTwist
//
//  Created by Marcel  on 12/28/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import UIKit
import AsyncDisplayKit

class FriendsBaseViewController: ASViewController<ASTableNode> {

    // MARK: - Properties
    var friends = [Friend]()
    var filteredFriends = [Friend]()
    
    // MARK: - Constants
    let tableNode: ASTableNode!
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Object life cycle
    init() {
        tableNode = ASTableNode()
        super.init(node: tableNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.backgroundColor = UIColor.TwistPalette.FlatGray
        tableNode.automaticallyAdjustsContentOffset = false
        tableNode.view.separatorStyle = .none
        tableNode.dataSource = self
        tableNode.delegate = self
        tableNode.leadingScreensForBatching = 2.5
        
        setupSearchController()
    }
    
    // MARK: - Search Controller
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Type to search"
//        navigationItem.title = "Friends"
//        navigationItem.searchController = searchController
        self.navigationItem.titleView = searchController.searchBar
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredFriends = friends.filter({(friend: Friend) -> Bool in
            let fullName = friend.firstName.lowercased() + friend.lastName.lowercased()
            
            return fullName.contains(searchText.lowercased())
        })
        tableNode.reloadData()
    }
    
    func isSearching() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    // MARK: Fetch
    
    func fetchNewBatchWithContext(_ context: ASBatchContext) {
        RequestManager.getDogsImages(completion: { response in
            for (index, imagerUrl) in (response as! [String]).enumerated() {
                let friend = Friend(id: index,
                                    firstName: "Marcel ",
                                    lastName: "Spinu" + String(index),
                                    birthday: "23 years old",
                                    country: "Moldova",
                                    phoneNumber: "37368892220",
                                    pictureURL: imagerUrl,
                                    sex: "Male")
                self.friends.append(friend)
            }
            self.tableNode.reloadData()
        }) { error in
            print(error)
        }
    }
}

// MARK: - TableNode Delegate
extension FriendsBaseViewController: ASTableDelegate, ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        if isSearching() {
            return filteredFriends.count
        }
        return friends.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let friend: Friend
        if isSearching() {
            friend = filteredFriends[indexPath.row]
        } else {
            friend = friends[indexPath.row]
        }
        
        return {
            return FriendCell(friend: friend)
        }
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        fetchNewBatchWithContext(context)
    }
}

// MARK: - SearchResultUpdater Delegate
extension FriendsBaseViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
