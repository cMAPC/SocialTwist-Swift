//
//  InviteViewController.swift
//  SocialTwist
//
//  Created by Marcel  on 12/31/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import UIKit
import AsyncDisplayKit

class InviteViewController: FriendsBaseViewController {

    // MARK: - Properties
    
    var headerHeight: CGFloat = 10
    
    // MARK: - Constants
    
    let inviteHeader = InviteHeader()

    // MARK: - Object life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inviteHeader.delegate = self
        inviteHeader.backgroundColor = UIColor.clear
        inviteHeader.collectionView.backgroundColor = UIColor.clear
    }
}

// MARK: - TableView delegate
extension InviteViewController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return inviteHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        // Insert new invitation in header
        let guest: Friend
        if isSearching() {
            guest = filteredFriends[indexPath.row]
        } else {
            guest = friends[indexPath.row]
        }
        
        if !inviteHeader.guests.contains(where: {$0.id == guest.id}) {
            inviteHeader.guests.append(guest)
            let row = inviteHeader.guests.count - 1
            let indexPath = IndexPath(row: row, section: 0)
            inviteHeader.collectionView.insertItems(at: [indexPath])
        }

        // Update(height) and layout header
        tableNode.performBatchUpdates({
            headerHeight = inviteHeader.intrinsicContentSize.height
        }) { (completed) in
            let delay = tableNode.contentOffset.y > 0 ? 0 : 0.2
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                tableNode.performBatchUpdates(nil, completion: nil)
            }
        }

        inviteHeader.collectionView.backgroundColor = UIColor.TwistPalette.FlatGray
    }
}

// MARK: - Invite header Delegate
extension InviteViewController: InviteHeaderDelegate {
    func didTapDeleteButton() {
        if inviteHeader.collectionView.numberOfItems(inSection: 0) == 0 {
            inviteHeader.collectionView.backgroundColor = UIColor.clear
        }
        tableNode.performBatchUpdates({
            headerHeight = inviteHeader.intrinsicContentSize.height
        }) { (completed) in
            self.tableNode.performBatchUpdates(nil, completion: nil)
        }
    }
}
