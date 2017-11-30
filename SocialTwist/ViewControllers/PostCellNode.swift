//
//  PostCellNode.swift
//  SocialTwist
//
//  Created by Marcel  on 11/29/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import AsyncDisplayKit

//-----------------------------
// MARK: - Protocol
//-----------------------------

protocol PostCellDelegate: class {
    func didTapPhotoButton(sender: ASButtonNode)
}

class PostCellNode: ASCellNode {
    
    //-----------------------------
    // MARK: - Properties
    //-----------------------------
    
    private lazy var userImageSize: CGSize = {
        return CGSize(width: 50.0, height: 50.0)
    }()
    
    private lazy var buttonSize: CGSize = {
        return CGSize(width: 52.0, height: 42.0)
    }()
    
    var eventImage: UIImage? { ///?????????????
        didSet {
            setupEventImageNode()
            setNeedsLayout()
        }
    }
    
    
    //-----------------------------
    // MARK: - Constants
    //-----------------------------
    
    weak var delegate: PostCellDelegate? // ??????????????????????
    
    private let event: Event // ???????????????????????
    
    private let userImageNode: ASNetworkImageNode
    private let evenImageNode: ASImageNode
    private let inputTextNode: ASEditableTextNode
    private let bottomDelimiterNode: ASDisplayNode
    private let categoryButtonNode: ASButtonNode
    private let photoButtonNode: ASButtonNode
    private let postButtonNode: ASButtonNode
    private let bottomSpacerNode: ASDisplayNode
    private let spacerNode: ASDisplayNode
    
    //-----------------------------
    // MARK: - Life cycle
    //-----------------------------
    
    init(event: Event) {
        self.event = event // ???????????????????
        
        userImageNode = ASNetworkImageNode()
        evenImageNode = ASImageNode()
        inputTextNode = ASEditableTextNode()
        bottomDelimiterNode = ASDisplayNode()
        categoryButtonNode = ASButtonNode()
        photoButtonNode = ASButtonNode()
        postButtonNode = ASButtonNode()
        bottomSpacerNode = ASDisplayNode()
        spacerNode = ASDisplayNode()
        
        super.init()
        setupNodes()
        buildNodeHierarchy()
    }
    
    override func didLoad() {
        inputTextNode.delegate = self
        
        photoButtonNode.addTarget(self, action: #selector(didTapPhotoButton(_:)), forControlEvents: .touchUpInside)
        categoryButtonNode.addTarget(self, action: #selector(didTapCategoryButton(_:)), forControlEvents: .touchUpInside)
        postButtonNode.addTarget(self, action: #selector(didTapPostButton(_:)), forControlEvents: .touchUpInside)
    }
    
    //-----------------------------
    // MARK: - Setup
    //-----------------------------
    
    private func setupNodes() {
        setupUserImageNode()
        setupEventImageNode()
        setupInputTextNode()
        setupBottomDelimiterNode()
        setupCategoryButtonNode()
        setupPhotoButtonNode()
        setupPostButtonNode()
        setupBottomSpacerNode()
        setupSpacerNode()
    }
    
    private func setupUserImageNode() {
        userImageNode.url = URL (string: event.creatorImageURL)
        userImageNode.style.preferredSize = userImageSize
        userImageNode.cornerRadius = 25.0
    }
    
    private func setupEventImageNode() {
        /*if let image = eventImage  {
            evenImageNode.style.preferredSize = userImageSize
            evenImageNode.image = image
        } else {
            evenImageNode.style.preferredSize = CGSize.zero
        }*/
        evenImageNode.style.preferredSize = userImageSize
        evenImageNode.image = #imageLiteral(resourceName: "uncharted")
    }
    
    private func setupInputTextNode() {
        inputTextNode.attributedPlaceholderText = NSAttributedString(string: "What's new ?")
        inputTextNode.backgroundColor = UIColor.red
    }
    
    private func setupBottomDelimiterNode() {
        bottomDelimiterNode.style.preferredSize = CGSize(width: ASDimensionAuto.value, height: 1.0)
        bottomDelimiterNode.backgroundColor = UIColor.TwistPalette.FlatGray
    }
    
    private func setupCategoryButtonNode() {
        categoryButtonNode.setImage(#imageLiteral(resourceName: "marker"), for: .normal)
        categoryButtonNode.style.preferredSize = buttonSize
    }
    
    private func setupPhotoButtonNode() {
        photoButtonNode.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        photoButtonNode.style.preferredSize = buttonSize
    }
    
    private func setupPostButtonNode() {
        postButtonNode.setTitle("POST", with: UIFont.boldSystemFont(ofSize: 13.0), with: UIColor.TwistPalette.DarkGray, for: .normal)
        postButtonNode.style.preferredSize = buttonSize
        postButtonNode.backgroundColor = UIColor.red
    }
    
    private func setupBottomSpacerNode() {
        bottomSpacerNode.style.preferredSize = CGSize(width: ASDimensionAuto.value, height: 10.0)
        bottomSpacerNode.backgroundColor = UIColor.TwistPalette.FlatGray
    }
    
    private func setupSpacerNode() {
        spacerNode.style.flexGrow = 1.0
    }
    
    private func buildNodeHierarchy() {
        addSubnode(userImageNode)
        addSubnode(evenImageNode)
        addSubnode(inputTextNode)
        addSubnode(bottomDelimiterNode)
        addSubnode(categoryButtonNode)
        addSubnode(photoButtonNode)
        addSubnode(postButtonNode)
        addSubnode(bottomSpacerNode)
    }
    
    //-----------------------------
    // MARK: - Layout
    //-----------------------------
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        let inputTextNodeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
//        let inputTextNodeLayout = ASInsetLayoutSpec(insets: inputTextNodeInsets, child: inputTextNode)
//        inputTextNodeLayout.style.preferredSize = CGSize(width: ASDimensionAuto.value, height: inputTextNode.frame.size.height)
        
        // User image node
        let userImageInsets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 10.0)
        let userImageLayout = ASInsetLayoutSpec(insets: userImageInsets, child: userImageNode)
        
        // Input node
        let inputTextNodeInsets = UIEdgeInsets(top: 15.0, left: 0.0, bottom: 15.0, right: 10.0)
        let inputTextNodeLayout = ASInsetLayoutSpec(insets: inputTextNodeInsets, child: inputTextNode)
        inputTextNodeLayout.style.flexShrink = 1.0
        inputTextNodeLayout.style.alignSelf = .center
        
        // Header stack
        let headerStackLayout = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .start,
                                                  alignItems: .start,
                                                  children: [userImageLayout, inputTextNodeLayout])
        
        // Image node
        let eventImageInsets = UIEdgeInsets(top: 0.0, left: 75.0, bottom: 10.0, right: 10.0)
        let eventImageLayout = ASInsetLayoutSpec(insets: eventImageInsets, child: evenImageNode)
        
        let eventImageStackLayout = ASStackLayoutSpec(direction: .horizontal,
                                                      spacing: 0.0,
                                                      justifyContent: .start,
                                                      alignItems: .start,
                                                      children: [eventImageLayout])
        // Footer stack
        let postButtonLayout = ASWrapperLayoutSpec(layoutElement: postButtonNode)
        
        let footerStackLayout = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0.0,
                                                  justifyContent: .start,
                                                  alignItems: .start,
                                                  children: [categoryButtonNode, photoButtonNode, spacerNode, postButtonLayout])
        
        // Vertical stack
        let verticalStackLayout = ASStackLayoutSpec.vertical()
        verticalStackLayout.children = [headerStackLayout, eventImageStackLayout, bottomDelimiterNode, footerStackLayout, bottomSpacerNode]
        
        return verticalStackLayout
    }
    
    //-----------------------------
    // MARK: - Action's
    //-----------------------------
    
    @objc func didTapPhotoButton(_ sender: ASButtonNode) {
        delegate?.didTapPhotoButton(sender: sender)
    }
    
    @objc func didTapCategoryButton(_ sender: ASButtonNode) {
        
    }
    
    @objc func didTapPostButton(_ sender: ASButtonNode) {
        
    }
}

//------------------------------------
// MARK: - ASEditableTextNodeDelegate
//------------------------------------

extension PostCellNode: ASEditableTextNodeDelegate {
    func editableTextNodeDidChangeSelection(_ editableTextNode: ASEditableTextNode, fromSelectedRange: NSRange, toSelectedRange: NSRange, dueToEditing: Bool) {
        self.setNeedsLayout()
    }
}
