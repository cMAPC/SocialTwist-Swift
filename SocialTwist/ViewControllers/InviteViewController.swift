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
    
    override func viewDidAppear(_ animated: Bool) {
        updateTableNode()
    }
    
    private func updateTableNode() {
        tableNode.performBatchUpdates({
            // perform table update
        }) { completed in
            self.tableNode.performBatchUpdates({
                
            }, completion: { completed in
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    if self.inviteHeader.guests.count != 0 {
                        self.inviteHeader.showContent()
                    }
                    self.view.layoutIfNeeded()
                })
            })
        }
    }
}

// MARK: - TableView delegate
extension InviteViewController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return inviteHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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

        // Update table node
        updateTableNode()
    }
}

// MARK: - Invite header Delegate
extension InviteViewController: InviteHeaderDelegate {
    func didTapDeleteButton() {
        if inviteHeader.guests.count == 0 {
            delegate?.didSelectGuests(guests: inviteHeader.guests)
        }
        updateTableNode()
    }
    
    func didTapExpandCollpaseButton() {
        updateTableNode()
    }
    
    func didTapInviteButton() {
        delegate?.didSelectGuests(guests: inviteHeader.guests)
        self.navigationController?.popViewController(animated: true)
    }
}

