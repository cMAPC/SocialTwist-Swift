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
    func didTapInviteButton(sender: ASButtonNode)
    func didTapPlaceButton(sender: ASButtonNode)
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
    
    private var placeholderAttributes: [NSAttributedStringKey: Any] {
        return [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15.0),
                .foregroundColor: UIColor.TwistPalette.DarkGray]
    }
    
    //-----------------------------
    // MARK: - Constants
    //-----------------------------
    
    private let event: Event // ???????????????????????
    weak var delegate: PostCellDelegate?
    
    private let userImageNode: ASNetworkImageNode
    let eventImageNode: ImageNode
    private let inputTextNode: ASEditableTextNode
    private let bottomDelimiterNode: ASDisplayNode
    private let placeButtonNode: ASButtonNode
    private let categoryButtonNode: ASButtonNode
    private let inviteButtonNode: ASButtonNode
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
        eventImageNode = ImageNode()
        inputTextNode = ASEditableTextNode()
        bottomDelimiterNode = ASDisplayNode()
        placeButtonNode = ASButtonNode()
        categoryButtonNode = ASButtonNode()
        inviteButtonNode = ASButtonNode()
        photoButtonNode = ASButtonNode()
        postButtonNode = ASButtonNode()
        bottomSpacerNode = ASDisplayNode()
        spacerNode = ASDisplayNode()
        
        super.init()
        selectionStyle = .none
        setupNodes()
        buildNodeHierarchy()
    }
    
    override func didLoad() {
        inputTextNode.delegate = self
        
        placeButtonNode.addTarget(self, action: #selector(didTapPlaceButton(_:)), forControlEvents: .touchUpInside)
        photoButtonNode.addTarget(self, action: #selector(didTapPhotoButton(_:)), forControlEvents: .touchUpInside)
        inviteButtonNode.addTarget(self, action: #selector(didTapInviteButton(_:)), forControlEvents: .touchUpInside)
        categoryButtonNode.addTarget(self, action: #selector(didTapCategoryButton(_:)), forControlEvents: .touchUpInside)
        postButtonNode.addTarget(self, action: #selector(didTapPostButton(_:)), forControlEvents: .touchUpInside)
        eventImageNode.deleteButton.addTarget(self, action: #selector(didTapDeleteButton(_:)), forControlEvents: .touchUpInside)
    }
    
    //-----------------------------
    // MARK: - Setup
    //-----------------------------
    
    private func setupNodes() {
        setupUserImageNode()
        setupInputTextNode()
        setupBottomDelimiterNode()
        setupPlaceButtonNode()
        setupCategoryButtonNode()
        setupInviteButtonNode()
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
    
    private func setupInputTextNode() {
        inputTextNode.attributedPlaceholderText = NSAttributedString(string: "What's new ?", attributes: placeholderAttributes)
        inputTextNode.maximumLinesToDisplay = 10
        inputTextNode.backgroundColor = UIColor.red
        inputTextNode.scrollEnabled = false
    }
    
    private func setupBottomDelimiterNode() {
        bottomDelimiterNode.style.preferredSize = CGSize(width: ASDimensionAuto.value, height: 1.0)
        bottomDelimiterNode.backgroundColor = UIColor.TwistPalette.FlatGray
    }
    
    private func setupPlaceButtonNode() {
        placeButtonNode.setImage(#imageLiteral(resourceName: "marker"), for: .normal)
        placeButtonNode.style.preferredSize = buttonSize
    }
    
    private func setupCategoryButtonNode() {
        categoryButtonNode.setImage(#imageLiteral(resourceName: "marker"), for: .normal)
        categoryButtonNode.style.preferredSize = buttonSize
    }
    
    private func setupInviteButtonNode() {
        inviteButtonNode.setImage(#imageLiteral(resourceName: "invite"), for: .normal)
        inviteButtonNode.style.preferredSize = buttonSize
    }
    
    private func setupPhotoButtonNode() {
        photoButtonNode.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        photoButtonNode.style.preferredSize = buttonSize
    }
    
    private func setupPostButtonNode() {
        postButtonNode.setTitle("POST",
                                with: UIFont.boldSystemFont(ofSize: 13.0),
                                with: UIColor.TwistPalette.DarkGray,
                                for: .normal)
        postButtonNode.style.preferredSize = buttonSize
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
        addSubnode(eventImageNode)
        addSubnode(inputTextNode)
        addSubnode(placeButtonNode)
        addSubnode(bottomDelimiterNode)
        addSubnode(categoryButtonNode)
        addSubnode(inviteButtonNode)
        addSubnode(photoButtonNode)
        addSubnode(postButtonNode)
        addSubnode(bottomSpacerNode)
    }
    
    //-----------------------------
    // MARK: - Layout
    //-----------------------------
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // User image node
        let userImageInsets = UIEdgeInsets(top: 10.0, left: 15.0, bottom: 0.0, right: 10.0)
        let userImageLayout = ASInsetLayoutSpec(insets: userImageInsets, child: userImageNode)
        
        // Input node
        let inputTextNodeInsets = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 5.0, right: 10.0)
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
//        let eventImageLayout = ASWrapperLayoutSpec(layoutElement: eventImageNode)
        let eventImageInsets = UIEdgeInsets(top: 0.0, left: 65.0, bottom: 8.0, right: 10.0)
        let eventImageLayout = ASInsetLayoutSpec(insets: eventImageInsets, child: eventImageNode)

        // Footer stack
        let postButtonLayout = ASWrapperLayoutSpec(layoutElement: postButtonNode)
        
        let footerStackLayout = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0.0,
                                                  justifyContent: .start,
                                                  alignItems: .start,
                                                  children: [placeButtonNode, categoryButtonNode, inviteButtonNode, photoButtonNode, spacerNode, postButtonLayout])
        
        // Vertical stack
        let verticalStackLayout = ASStackLayoutSpec.vertical()
        verticalStackLayout.children = [headerStackLayout, eventImageLayout, bottomDelimiterNode, footerStackLayout, bottomSpacerNode]
        
        return verticalStackLayout
    }
    
    //-----------------------------
    // MARK: - Action's
    //-----------------------------
    
    @objc func didTapPhotoButton(_ sender: ASButtonNode) {
        delegate?.didTapPhotoButton(sender: sender)
    }
    
    @objc func didTapPlaceButton(_ sender: ASButtonNode) {
        delegate?.didTapPlaceButton(sender: sender)
    }
    
    @objc func didTapCategoryButton(_ sender: ASButtonNode) {
        
    }
    
    @objc func didTapInviteButton(_ sender: ASButtonNode) {
        delegate?.didTapInviteButton(sender: sender)
    }
    
    @objc func didTapPostButton(_ sender: ASButtonNode) {
        
    }
    
    @objc func didTapDeleteButton(_ sender: ASButtonNode) {
        eventImageNode.image = nil
        eventImageNode.deleteButton.isHidden = true
        setNeedsLayout()
    }
    
    //-----------------------------
    // MARK: - Text Attributes
    //-----------------------------
    
//    private func placeholderAttriubtes() -> NSAttributedString {
//        let placeholderAttributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0),
//                                     .foregroundColor: UIColor.TwistPalette.FlatGray]
//
//    }
}

//------------------------------------
// MARK: - ASEditableTextNodeDelegate
//------------------------------------

extension PostCellNode: ASEditableTextNodeDelegate {
    func editableTextNodeDidChangeSelection(_ editableTextNode: ASEditableTextNode, fromSelectedRange: NSRange, toSelectedRange: NSRange, dueToEditing: Bool) {
        setNeedsLayout()
    }
}

//------------------------------------
// MARK: - Image Node
//------------------------------------

class ImageNode: ASDisplayNode {
    private let imageNode: ASImageNode
    let deleteButton: ASButtonNode
    
    var image: UIImage? {
        didSet {
            setupNodes()
            setNeedsLayout()
        }
    }
    
    //-----------------------------
    // MARK: - Life cycle
    //-----------------------------
    
    override init() {
        imageNode = ASImageNode()
        deleteButton = ASButtonNode()
        
        super.init()
        addSubnode(imageNode)
        addSubnode(deleteButton)
    }
    
    //-----------------------------
    // MARK: - Setup
    //-----------------------------
    
    private func setupNodes() {
        if image != nil {
            setupImageNode()
            setupDeleteButtonNode()
        } else {
            imageNode.style.preferredSize = CGSize.zero
            deleteButton.style.preferredSize = CGSize.zero
        }
    }
    
    private func setupImageNode() {
        imageNode.style.preferredSize = CGSize(width: 50.0, height: 50.0)
        imageNode.cornerRadius = 3.0
        imageNode.image = self.image
    }
    
    private func setupDeleteButtonNode() {
        deleteButton.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
        deleteButton.backgroundColor = UIColor.white
        deleteButton.style.preferredSize = CGSize(width: 20.0, height: 20.0)
        deleteButton.cornerRadius = 10.0
        deleteButton.isHidden = false
    }
    
    //-----------------------------
    // MARK: - Layout
    //-----------------------------
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        deleteButton.style.layoutPosition = CGPoint(x: 50.0, y: 0.0)
        imageNode.style.layoutPosition = CGPoint(x: 10.0, y: 10.0)
        
        return ASAbsoluteLayoutSpec(sizing: .sizeToFit, children: [imageNode, deleteButton])
    }

}
