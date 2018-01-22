//
//  InviteViewController.swift
//  SocialTwist
//
//  Created by Marcel  on 12/31/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import UIKit
import AsyncDisplayKit

// MARK: - Protocol
protocol InviteViewControllerDelegate: class {
    func didSelectGuests(guests: [Friend])
}

class InviteViewController: FriendsBaseViewController {

    // MARK: - Constants
    weak var delegate: InviteViewControllerDelegate?
    let inviteHeader = InviteHeader()

    // MARK: - Object life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inviteHeader.delegate = self
    }
}

// MARK: - TableView delegate
extension InviteViewController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return inviteHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        print(inviteHeader.height)
        return inviteHeader.height
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        let guest: Friend
        if isSearching() {
            guest = filteredFriends[indexPath.row]
        } else {
            guest = friends[indexPath.row]
        }
        
        // Insert new guest in header
        inviteHeader.insertNewGuest(guest: guest)

        // Update and layout header
//        tableNode.performBatchUpdates({
//
//        }) { (completed) in
//            let delay = tableNode.contentOffset.y > 0 ? 0 : 0.2
//            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//                tableNode.performBatchUpdates(nil, completion: nil)
//            }
//        }
        
        tableNode.performBatchUpdates(nil) { (completed) in
            self.tableNode.performBatchUpdates(nil, completion: nil)
        }
        
        delegate?.didSelectGuests(guests: inviteHeader.guests)
    }
}

// MARK: - Invite header Delegate
extension InviteViewController: InviteHeaderDelegate {
    func didTapDeleteButton() {
        tableNode.performBatchUpdates(nil) { (completed) in
            self.tableNode.performBatchUpdates(nil, completion: nil)
        }
    }
}
