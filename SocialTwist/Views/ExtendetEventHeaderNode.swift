//
//  ExtendetEventHeaderNode.swift
//  SocialTwist
//
//  Created by Marcel  on 12/9/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ExtendetEventHeaderNode: ASDisplayNode {
    
    //-----------------------------
    // MARK: - Constants
    //-----------------------------
    
    private let event: Event
    
    private let creatorImageNode: ASNetworkImageNode
    private let eventImageNode: ASNetworkImageNode
    private let eventCategoryImageNode: ASImageNode
    private let creatorNameNode: ASTextNode
    private let eventDescriptionNode: ASTextNode
    
    private let topDelimiterNode: ASDisplayNode
    private let bottomDelimiterNode: ASDisplayNode
    private let attendButtonNode: ASButtonNode
    
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
        attendButtonNode = ASButtonNode()
        
        super.init()
        backgroundColor = UIColor.white
        setupNodes()
        buildNodeHierarchy()
        
        let min = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/3.0 * 2.0)
        let max = CGSize(width: UIScreen.main.bounds.size.width, height: CGFloat.greatestFiniteMagnitude)
        
        self.layoutThatFits(ASSizeRange(min: min, max: max))
    }
    override func didLoad() {
        print("Size is \(self.calculatedSize.height)")
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
        setupAttendButtonNode()
    }
    
    private func setupCreatorImageNode() {
        creatorImageNode.url = URL(string: event.creatorImageURL)
        creatorImageNode.style.preferredSize = CGSize(width: 50, height: 50)
        creatorImageNode.cornerRadius = 25.0
    }
    
    private func setupEventImageNode() {
        eventImageNode.url = URL(string: event.imageURL)
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
    
    private func setupAttendButtonNode() {
        attendButtonNode.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        attendButtonNode.style.flexGrow = 1.0
        attendButtonNode.style.preferredSize = CGSize(width: ASDimensionAuto.value, height: 42.0)
    }
    
    private func buildNodeHierarchy() {
        addSubnode(creatorImageNode)
        addSubnode(eventImageNode)
        addSubnode(eventCategoryImageNode)
        addSubnode(creatorNameNode)
        addSubnode(eventDescriptionNode)
        
        addSubnode(topDelimiterNode)
        addSubnode(bottomDelimiterNode)
        addSubnode(attendButtonNode)
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
                                                  children: [attendButtonNode])
        
        
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
        
        // Vertical children
        let verticalChildren = [headerStackLayout, topDelimiterLayout, descriptionStackLayout,
                                eventImageLayout, bottomDelimiterLayout, footerStackLayout]
        
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
