//
//  CommentsHeaderNode.swift
//  SocialTwist
//
//  Created by Marcel  on 12/8/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import AsyncDisplayKit

//-----------------------------
// MARK: - Protocol
//-----------------------------

protocol CommentsHeaderDelegate: class {
    func didTapDismissButton(sender: ASButtonNode)
}

class CommentsHeaderNode: ASDisplayNode {
    
    // MARK: - Constants
    weak var delegate: CommentsHeaderDelegate?
    private let dismissButtonNode: ASButtonNode
    private let attendersCountButtonNode: ASButtonNode
    private let likesCountButtonNode: ASButtonNode
    private let spacerNode: ASDisplayNode
    
    // MARK: - Object life cycle
    
    override init() {
        dismissButtonNode = ASButtonNode()
        attendersCountButtonNode = ASButtonNode()
        likesCountButtonNode = ASButtonNode()
        spacerNode = ASDisplayNode()
        
        super.init()
        self.backgroundColor = UIColor.white
        setupDismissButton()
        setupAttendersCountButtonNode()
        setupLikesCountButtonNode()
        setupSpacerNode()
        addSubnode(dismissButtonNode)
        addSubnode(attendersCountButtonNode)
        addSubnode(likesCountButtonNode)
    }
    
    override func didLoad() {
        dismissButtonNode.addTarget(self, action: #selector(didTapDismissButton(_:)), forControlEvents: .touchUpInside)
    }
    
    // MARK: - Setup
    
    private func setupDismissButton() {
        dismissButtonNode.setImage(#imageLiteral(resourceName: "dismiss"), for: .normal)
        dismissButtonNode.style.preferredSize = CGSize(width: 52.0, height: 42.0)
    }
    
    private func setupAttendersCountButtonNode() {
        attendersCountButtonNode.setImage(#imageLiteral(resourceName: "dismiss"), for: .normal)
        attendersCountButtonNode.style.preferredSize = CGSize(width: 52.0, height: 42.0)
        attendersCountButtonNode.setTitle("58", with: UIFont.boldSystemFont(ofSize: 13), with: UIColor.black, for: .normal)
        attendersCountButtonNode.contentSpacing = 4
    }
    
    private func setupLikesCountButtonNode() {
        likesCountButtonNode.setImage(#imageLiteral(resourceName: "dismiss"), for: .normal)
        likesCountButtonNode.setTitle("23", with: UIFont.boldSystemFont(ofSize: 13), with: UIColor.black, for: .normal)
        likesCountButtonNode.contentSpacing = 4
        likesCountButtonNode.style.preferredSize = CGSize(width: 52.0, height: 42.0)
    }
    
    private func setupSpacerNode() {
        spacerNode.style.flexGrow = 1.0
    }
    
    // MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let likeButtonInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        let likeButtonLayout = ASInsetLayoutSpec(insets: likeButtonInsets, child: likesCountButtonNode)
        
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0.0,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [likeButtonLayout, attendersCountButtonNode, spacerNode, dismissButtonNode])
    }
    
    // Action's
    
    @objc private func didTapDismissButton(_ sender: ASButtonNode) {
        delegate?.didTapDismissButton(sender: sender)
    }
}
