//
//  FriendCell.swift
//  SocialTwist
//
//  Created by Marcel  on 12/28/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import AsyncDisplayKit

class FriendCell: ASCellNode {

    // MARK: - Constans
    let friendContainer: FriendContainerNode
    
    // MARK: - Object life cycle
    init(friend: Friend) {
        friendContainer = FriendContainerNode(friend: friend)
        super.init()
        selectionStyle = .none
        addSubnode(friendContainer)
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsetsMake(0, 10, 10, 10), child: friendContainer)
    }
}
