//
//  EventCellNode.swift
//  SocialTwist
//
//  Created by Marcel  on 11/22/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import AsyncDisplayKit

//-----------------------------
// MARK: - Protocol
//-----------------------------
protocol EventCellDelegate: class {
    func didTapLikeButton(sender: ASButtonNode)
    func didTapDislikeButton(sender: ASButtonNode)
    func didTapCommentButton(sender: ASButtonNode)
}

class EventCellNode: ASCellNode {
    
    //-----------------------------
    // MARK: - Properties
    //-----------------------------
    
    private lazy var creatorImageSize: CGSize = {
        return CGSize(width: 50, height: 50)
    }()
    
    private lazy var buttonSize: CGSize = {
        return CGSize(width: ASDimensionAuto.value, height: 42.0)
    }()

    //-----------------------------
    // MARK: - Constants
    //-----------------------------
    
    weak var delegate: EventCellDelegate?
    
    private let event: Event
    private let creatorImageNode: ASNetworkImageNode
    private let eventImageNode: ASNetworkImageNode
    private let eventCategoryImageNode: ASImageNode
    private let creatorNameNode: ASTextNode
    private let eventDescriptionNode: ASTextNode
    
    private let topDelimiterNode: ASDisplayNode
    private let bottomDelimiterNode: ASDisplayNode
    private let spacingNode: ASDisplayNode
    private let likeButtonNode: ASButtonNode
    private let dislikeButtonNode: ASButtonNode
    private let commentButtonNode: ASButtonNode
    
    //-----------------------------
    // MARK: - Life cycle
    //-----------------------------
    
    init(event: Event) {
        self.event = event
        
        creatorImageNode = ASNetworkImageNode()
        eventImageNode = ASNetworkImageNode()
        eventCategoryImageNode = ASImageNode()
        creatorNameNode = ASTextNode()
        eventDescriptionNode = ASTextNode()
        
        topDelimiterNode = ASDisplayNode()
        bottomDelimiterNode = ASDisplayNode()
        spacingNode = ASDisplayNode()
        likeButtonNode = ASButtonNode()
        dislikeButtonNode = ASButtonNode()
        commentButtonNode = ASButtonNode()
        
        super.init()
        self.selectionStyle = .none
        setupNodes()
        buildNodeHierarchy()
    }
    
    override func didLoad() {
        likeButtonNode.addTarget(self, action: #selector(didTapLikeButton(_:)), forControlEvents: .touchUpInside)
        dislikeButtonNode.addTarget(self, action: #selector(didTapDislikeButton(_:)), forControlEvents: .touchUpInside)
        commentButtonNode.addTarget(self, action: #selector(didTapCommentButton(_:)), forControlEvents: .touchUpInside)
    }
    
    //-----------------------------
    // MARK: - Setup
    //-----------------------------
    
    private func setupNodes() {
        setupCreatorImageNode()
        setupEventImageNode()
        setupEventCategoryImageNode()
        setupCreatorNameNode()
        setupEventDescriptionNode()
        
        setupTopDelimiterNode()
        setupBottomDelimiterNode()
        setupSpacingNode()
        setupLikeButtonNode()
        setupDislikeButtonNode()
        setupCommentButtonNode()
    }
    
    private func setupCreatorImageNode() {
        creatorImageNode.url = URL(string: event.creatorImageURL)
        creatorImageNode.style.preferredSize = creatorImageSize
        creatorImageNode.cornerRadius = 25.0
    }
    
    private func setupEventImageNode() {
        eventImageNode.url = URL(string: event.imageURL)
        /*
        eventImageNode.clipsToBounds = true
        eventImageNode.delegate = self
        eventImageNode.placeholderFadeDuration = 0.15
        eventImageNode.contentMode = .scaleAspectFill
        eventImageNode.needsDisplayOnBoundsChange = true
        eventImageNode.shouldRenderProgressImages = true
         */
    }
    
    private func setupEventCategoryImageNode() {
        eventCategoryImageNode.style.preferredSize = CGSize(width: 30.0, height: 30.0)
        eventCategoryImageNode.image = #imageLiteral(resourceName: "Attending")
    }
    
    private func setupCreatorNameNode() {
        creatorNameNode.attributedText = creatorNameTextAttriubtes()
        creatorNameNode.maximumNumberOfLines = 2
    }
    
    private func setupEventDescriptionNode() {
        eventDescriptionNode.attributedText = NSAttributedString(string: event.description, attributes: nil)
        eventDescriptionNode.maximumNumberOfLines = 5
    }
    
    private func setupTopDelimiterNode() {
        topDelimiterNode.style.preferredSize = CGSize(width: ASDimensionAuto.value, height: 1.0)
        topDelimiterNode.backgroundColor = UIColor.TwistPalette.FlatGray
    }
    
    private func setupBottomDelimiterNode() {
        bottomDelimiterNode.style.preferredSize = CGSize(width: ASDimensionAuto.value, height: 1.0)
        bottomDelimiterNode.backgroundColor = UIColor.TwistPalette.FlatGray
    }
    
    private func setupSpacingNode() {
        spacingNode.style.preferredSize = CGSize(width: ASDimensionAuto.value, height: 10.0)
        spacingNode.backgroundColor = UIColor.TwistPalette.FlatGray
    }
    
    private func setupLikeButtonNode() {
        likeButtonNode.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        likeButtonNode.style.flexGrow = 1.0
        likeButtonNode.style.preferredSize = buttonSize
    }
    
    private func setupDislikeButtonNode() {
        dislikeButtonNode.setImage(#imageLiteral(resourceName: "dislike"), for: .normal)
        dislikeButtonNode.style.flexGrow = 1.0
        dislikeButtonNode.style.preferredSize = buttonSize
    }
    
    private func setupCommentButtonNode() {
        commentButtonNode.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        commentButtonNode.style.flexGrow = 1.0
        commentButtonNode.style.preferredSize = buttonSize
    }
    
    private func buildNodeHierarchy() {
        addSubnode(creatorImageNode)
        addSubnode(eventImageNode)
        addSubnode(eventCategoryImageNode)
        addSubnode(creatorNameNode)
        addSubnode(eventDescriptionNode)
        
        addSubnode(topDelimiterNode)
        addSubnode(bottomDelimiterNode)
        addSubnode(spacingNode)
        addSubnode(likeButtonNode)
        addSubnode(dislikeButtonNode)
        addSubnode(commentButtonNode)
    }
    
    //-----------------------------
    // MARK: - Layout
    //-----------------------------
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        // Creator image node
        let creatorImageInsets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 10.0)
        let creatorImageLayout = ASInsetLayoutSpec(insets: creatorImageInsets, child: creatorImageNode)
        
        // Creator name node
        let creatorNameInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 10.0)
        let creatorNameLayout = ASInsetLayoutSpec(insets: creatorNameInsets, child: creatorNameNode)
        creatorNameLayout.style.flexShrink = 0.5
        
        // Header stack
        let headerStackLayout = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .start,
                                                  alignItems: .center,
                                                  children: [creatorImageLayout, creatorNameLayout])
        
        // Delimiters nodes
        let topDelimiterLayout = ASWrapperLayoutSpec(layoutElement: topDelimiterNode)
        let bottomDelimiterLayout = ASWrapperLayoutSpec(layoutElement: bottomDelimiterNode)
        
        // Footer stack
        let footerStackLayout = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .spaceBetween,
                                                  alignItems: .center,
                                                  children: [likeButtonNode, commentButtonNode, dislikeButtonNode])
        
        
        // Event description stack
        let categoryImageInsets = UIEdgeInsets(top: 10.0, left: 23.0, bottom: 10.0, right: 10.0)
        let categoryImageLayout = ASInsetLayoutSpec(insets: categoryImageInsets, child: eventCategoryImageNode)
        
        let eventDescriptionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        let eventDescriptionLayout = ASInsetLayoutSpec(insets: eventDescriptionInsets, child: eventDescriptionNode)
        eventDescriptionLayout.style.flexShrink = 1.0
        
        let descriptionStackLayout = ASStackLayoutSpec(direction: .horizontal,
                                                       spacing: 0.0,
                                                       justifyContent: .start,
                                                       alignItems: .center,
                                                       children: [categoryImageLayout, eventDescriptionLayout])
        
        
        // Event image node
        let eventImageLayout: ASLayoutSpec
        if event.imageURL.isEmpty {
            eventImageLayout = ASWrapperLayoutSpec(layoutElement: eventImageNode)
        } else {
            eventImageLayout = ASRatioLayoutSpec(ratio: 1.0, child: eventImageNode)
        }
        
        // Spacing node
        let spacingNodeLayout = ASWrapperLayoutSpec(layoutElement: spacingNode)
        
        // Vertical children
        let verticalChildren = [headerStackLayout, topDelimiterLayout, descriptionStackLayout,
                                eventImageLayout, bottomDelimiterLayout, footerStackLayout, spacingNodeLayout]
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.children = verticalChildren
        
        /*
         let verticalStack = ASStackLayoutSpec(direction: .vertical,
         spacing: 0,
         justifyContent: .start,
         alignItems: .stretch,
         children: verticalChildren)
         */
        
        return verticalStack
    }
    
    //-----------------------------
    // MARK: - Action's
    //-----------------------------
    
    @objc func didTapLikeButton(_ sender: ASButtonNode) {
        delegate?.didTapLikeButton(sender: sender)
    }
    
    @objc func didTapDislikeButton(_ sender: ASButtonNode) {
        delegate?.didTapDislikeButton(sender: sender)
    }
    
    @objc func didTapCommentButton(_ sender: ASButtonNode) {
        delegate?.didTapCommentButton(sender: sender)
    }
    
    //-----------------------------
    // MARK: - Text Attributes
    //-----------------------------
    
    private func creatorNameTextAttriubtes() -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: "\(event.creatorName) at    \(event.place)")
        
        // Text attachment
        let textAttachment = NSTextAttachment()
        textAttachment.image = UIImage(cgImage: #imageLiteral(resourceName: "marker higtlighted").cgImage!, scale: 1.8, orientation: .up)
        let attributedString = NSAttributedString(attachment: textAttachment)
        mutableAttributedString.replaceCharacters(in: NSMakeRange(event.creatorName.count + 5, 1), with: attributedString)
        
        // Editing
        mutableAttributedString.beginEditing()
        mutableAttributedString.addAttribute(.font,
                                             value: UIFont.boldSystemFont(ofSize: 13.0),
                                             range: NSMakeRange(0, event.creatorName.count))
        
        mutableAttributedString.addAttributes([.font: UIFont.systemFont(ofSize: 13.4),
                                               .foregroundColor: UIColor.TwistPalette.DarkGray],
                                              range: NSMakeRange(event.creatorName.count + 1, 2))
        
        mutableAttributedString.addAttributes([.font: UIFont.boldSystemFont(ofSize: 13.0),
                                               .foregroundColor: UIColor.TwistPalette.FlatBlue],
                                              range: NSMakeRange(event.creatorName.count + 7, event.place.count))
        mutableAttributedString.endEditing()

        return mutableAttributedString
    }
}
