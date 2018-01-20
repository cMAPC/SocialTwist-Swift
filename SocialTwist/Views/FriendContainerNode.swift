//
//  FriendContainerNode.swift
//  SocialTwist
//
//  Created by Marcel  on 12/28/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import AsyncDisplayKit

class FriendContainerNode: ASDisplayNode {
    // MARK: - Constants
    let friend: Friend
    private let imageNode: ASNetworkImageNode
    private let nameNode: ASTextNode
    private let messageButtonNode: ASButtonNode
    private let spacerNode: ASDisplayNode
    
    // MARK: - Properties
    private lazy var nameAttriubtes: NSMutableAttributedString = {
        let fullName = "\(friend.firstName) \(friend.lastName)"
        let detail = "\(friend.birthday), \(friend.country)"
        let string = "\(fullName)\n\(detail)"
        let mutableAttributedString = NSMutableAttributedString(string: string)
        
        mutableAttributedString.beginEditing()
        mutableAttributedString.addAttribute(.font,
                                             value: UIFont.boldSystemFont(ofSize: 14.0),
                                             range: NSMakeRange(0, fullName.count))
        mutableAttributedString.addAttributes([.font: UIFont.systemFont(ofSize: 12.0),
                                               .foregroundColor: UIColor.TwistPalette.DarkGray],
                                              range: NSMakeRange(fullName.count + 1, detail.count))
        mutableAttributedString.endEditing()
        
        return mutableAttributedString
    }()
    
    // MARK: - Object life cycle
    init(friend: Friend) {
        self.friend = friend
        
        imageNode = ASNetworkImageNode()
        nameNode = ASTextNode()
        messageButtonNode = ASButtonNode()
        spacerNode = ASDisplayNode()
        
        super.init()
        setupNodes()
        buildNodeHierarchy()
    }
    
    override func didLoad() {
        self.backgroundColor = UIColor.white
        self.cornerRadius = 16.0
    }
    
    // MARK: - Setup
    private func setupNodes() {
        setupImageNode()
        setupNameNode()
        setupMessageButtonNode()
        setupSpacerNode()
    }
    
    private func setupImageNode() {
        imageNode.url = URL(string: friend.pictureURL)
        imageNode.style.preferredSize = CGSize(width: 55.0, height: 55.0)
        imageNode.cornerRadius = 11
//        imageNode.shadowRadius = 8
//        imageNode.shadowColor = UIColor.black.cgColor
//        imageNode.shadowOpacity = 0.7
//        imageNode.shadowOffset = CGSize(width: 0, height: 1)
//        imageNode.clipsToBounds = false;
    }
    
    private func setupNameNode() {
        nameNode.attributedText = nameAttriubtes
    }
    
    private func setupMessageButtonNode() {
        messageButtonNode.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        messageButtonNode.style.preferredSize = CGSize(width: 36, height: 36)
    }
    
    private func setupSpacerNode() {
        spacerNode.style.flexGrow = 1.0
    }
    
    private func buildNodeHierarchy() {
        addSubnode(imageNode)
        addSubnode(nameNode)
        addSubnode(messageButtonNode)
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // Image layout
        let imageNodeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 10.0)
        let imageNodeLayout = ASInsetLayoutSpec(insets: imageNodeInsets, child: imageNode)
        
        // Name layout
        let nameNodeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 10.0)
        let nameNodeLayout = ASInsetLayoutSpec(insets: nameNodeInsets, child: nameNode)
        
        // Message button layout
        let messageButtonNodeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        let messageButtonNodeLayout = ASInsetLayoutSpec(insets: messageButtonNodeInsets, child: messageButtonNode)
        messageButtonNodeLayout.style.alignSelf = .end
        
        // Vertical stack
        let hStack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 0.0,
                                       justifyContent: .start,
                                       alignItems: .center,
                                       children: [imageNodeLayout, nameNodeLayout, spacerNode, messageButtonNodeLayout])
        return hStack
    }
}
