//
//  CommentCellNode.swift
//  SocialTwist
//
//  Created by Marcel  on 12/5/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import AsyncDisplayKit

class CommentCellNode: ASCellNode {
    
    // MARK: - Constants
    
    private let containerNode: ContainerNode
    
    // MARK: - Object life cycle
    
    init(comment: Comment) {
        containerNode = ContainerNode(comment: comment)
        super.init()
        addSubnode(containerNode)
    }
    
    // MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsetsMake(10, 10, 0, 10), child: containerNode)
    }
    
}

class ContainerNode: ASDisplayNode {
    
    // MARK: - Constants
    
    private let comment: Comment
    private let imageNode: ASNetworkImageNode
    private let nameNode: ASTextNode
    private let commentNode: ASTextNode
    private let dateNode: ASTextNode
    
    // MARK: - Object life cycle
    
    init(comment: Comment) {
        self.comment = comment
        imageNode = ASNetworkImageNode()
        nameNode = ASTextNode()
        commentNode = ASTextNode()
        dateNode = ASTextNode()
        
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
        setupCommentNode()
        setupDateNode()
    }
    
    private func setupImageNode() {
        imageNode.url = URL(string: comment.creatorPictureURL)
        imageNode.style.preferredSize = CGSize(width: 36.0, height: 36.0)
        imageNode.cornerRadius = 18.0
    }
    
    private func setupNameNode() {
        nameNode.attributedText = NSAttributedString(string: comment.creatorName,
                                                     attributes: [.font : UIFont.boldSystemFont(ofSize: 14.0)])
    }
    
    private func setupCommentNode() {
        commentNode.attributedText = NSAttributedString(string: comment.comment)
    }
    
    private func setupDateNode() {
        dateNode.attributedText = NSAttributedString(string: comment.date,
                                                     attributes: [.font             : UIFont.systemFont(ofSize: 12.0),
                                                                  .foregroundColor  : UIColor.TwistPalette.DarkGray])
    }
    
    private func buildNodeHierarchy() {
        addSubnode(imageNode)
        addSubnode(nameNode)
        addSubnode(commentNode)
        addSubnode(dateNode)
    }
    
    // MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        // Image layout
        let imageNodeInsets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 10.0)
        let imageNodeLayout = ASInsetLayoutSpec(insets: imageNodeInsets, child: imageNode)
        
        // Name layout
        let nameNodeInsets = UIEdgeInsets(top: 15.0, left: 0.0, bottom: 5.0, right: 10.0)
        let nameNodeLayout = ASInsetLayoutSpec(insets: nameNodeInsets, child: nameNode)
        
        // Comment layout
        let commentNodeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 5.0, right: 10.0)
        let commentNodeLayout = ASInsetLayoutSpec(insets: commentNodeInsets, child: commentNode)
        
        // Date layou
        let dateNodeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 10.0, right: 20.0)
        let dateNodeLayout = ASInsetLayoutSpec(insets: dateNodeInsets, child: dateNode)
        dateNodeLayout.style.alignSelf = .end

        // Vertical stack
        let vStack = ASStackLayoutSpec(direction: .vertical,
                                       spacing: 0.0,
                                       justifyContent: .start,
                                       alignItems: .start,
                                       children: [nameNodeLayout, commentNodeLayout, dateNodeLayout])
        
        vStack.style.flexShrink = 1.0
        vStack.style.flexGrow = 1.0
        
        // Horizontal stack
        let hStack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 0.0,
                                       justifyContent: .start,
                                       alignItems: .start,
                                       children: [imageNodeLayout, vStack])
        return hStack
    }
}
