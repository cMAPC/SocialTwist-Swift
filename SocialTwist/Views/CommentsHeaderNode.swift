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
    private let spacerNode: ASDisplayNode
    
    // MARK: - Object life cycle
    
    override init() {
        dismissButtonNode = ASButtonNode()
        spacerNode = ASDisplayNode()
        
        super.init()
        self.backgroundColor = UIColor.white
        setupDismissButton()
        setupSpacerNode()
        addSubnode(dismissButtonNode)
    }
    
    override func didLoad() {
        dismissButtonNode.addTarget(self, action: #selector(didTapDismissButton(_:)), forControlEvents: .touchUpInside)
    }
    
    // MARK: - Setup
    
    private func setupDismissButton() {
        dismissButtonNode.setImage(#imageLiteral(resourceName: "dismiss"), for: .normal)
        dismissButtonNode.style.preferredSize = CGSize(width: 52.0, height: 42.0)
    }
    
    private func setupSpacerNode() {
        spacerNode.style.flexGrow = 1.0
    }
    
    // MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0.0,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [spacerNode, dismissButtonNode])
    }
    
    // Action's
    
    @objc private func didTapDismissButton(_ sender: ASButtonNode) {
        delegate?.didTapDismissButton(sender: sender)
    }
}
