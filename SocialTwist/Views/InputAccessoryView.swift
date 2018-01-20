//
//  InputAccessoryView.swift
//  SocialTwist
//
//  Created by Marcel  on 12/13/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import UIKit

protocol InputAccessoryDelegate: class {
    func didFinishEditing()
}

class InputAccessoryView: UIView {
    
    // MARK: - Constants
    
    let textView = UITextView()
    let postButton = UIButton()
    let emojiButton = UIButton()
    
    // MARK: - Variables
    
    weak var delegate: InputAccessoryDelegate?
    var isEdinting = true
    var firstLine = ""
    var allText = ""
    
    
    
    override var intrinsicContentSize: CGSize {
        // Calculate intrinsicContentSize that will fit all the text

        if self.textView.text == firstLine {
            self.textView.text = allText
        }
        
        if textView.text == allText {
            setCursorPositionToEnd()
        }
        
        if isEdinting == true {
            scrollToBottom()
        }
        
        let textSize = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: CGFloat.greatestFiniteMagnitude))

        if textSize.height > 96 && isEdinting == true {
            self.textView.isScrollEnabled = true
            return CGSize(width: bounds.width, height: 100)
        } else if isEdinting == false {
            self.textView.text = firstLine
            return CGSize(width: bounds.width, height: 40)
        } else {
            return CGSize(width: bounds.width, height: textSize.height)
        }
    }
    
    // MARK: - Object life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        // This is required to make the view grow vertically
        autoresizingMask = .flexibleHeight
        
        // Build view hierarchy
        addSubview(textView)
        addSubview(postButton)
        addSubview(emojiButton)
        
        setupTextView()
        setupPostButton()
        setupEmojiButton()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupTextView() {
        textView.textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8)
        textView.backgroundColor = UIColor.TwistPalette.LowGray
        textView.layer.borderColor = UIColor.TwistPalette.MiddleGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 16.0
        textView.font = UIFont.systemFont(ofSize: 13)
        
        textView.showsVerticalScrollIndicator = false
        textView.delegate = self
        
        // Disabling textView scrolling prevents some undesired effects,
        // like incorrect contentOffset when adding new line
        textView.isScrollEnabled = false
    }
    
    private func setupConstraints() {
        let views = ["v0": textView,
                     "v1": postButton,
                     "v2": emojiButton]
        textView.translatesAutoresizingMaskIntoConstraints = false
        postButton.translatesAutoresizingMaskIntoConstraints = false
        emojiButton.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0][v2(>=40)][v1(>=40)]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v0]-5-|", options: [], metrics: nil, views: views))
        

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1(42)]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v2(42)]|", options: [], metrics: nil, views: views))
    }
    
    private func setupPostButton() {
        postButton.setImage(#imageLiteral(resourceName: "send"), for: .normal)
    }
    
    private func setupEmojiButton() {
        emojiButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
    }
    
    // MARK: - Text View Helper's
    
    private func scrollToBottom() {
        let bottomOffset = textView.contentSize.height - self.textView.bounds.size.height
        let contentOffset = CGPoint(x: 0, y: bottomOffset)
        textView.setContentOffset(contentOffset, animated: true)
    }
    
    private func setCursorPositionToEnd() {
        textView.selectedRange = NSMakeRange(textView.text.count, 0);
    }
    
    
    func truncateString(toWidth width: CGFloat, withFont font: UIFont, text: String) -> String {

        if text.isEmpty {
            return ""
        }
        
        var truncatedString = text
        var ellipsis = "..."
        var width = width

        // Get range for last character in string
        var range = NSRange(location: truncatedString.count, length: 1)
        
        if truncatedString.size(withAttributes: [.font: font]).width > width {
            width -= ellipsis.size(withAttributes: [.font: font]).width
            // Loop, deleting characters until string fits within width
            while truncatedString.size(withAttributes: [.font: font]).width > width {
                // Delete character at end
                if let subrange = Range<String.Index>(range, in: truncatedString) {
                    truncatedString.removeSubrange(subrange)
                }
                // Move back another character
                range.location -= 1
            }
        } else {
            ellipsis = " "
        }
        
        if let subrange = Range<String.Index>(range, in: truncatedString) {
            truncatedString.replaceSubrange(subrange, with: ellipsis)
        }
        return truncatedString
    }
}

// MARK: UITextViewDelegate

extension InputAccessoryView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // Re-calculate intrinsicContentSize when text changes
        isEdinting = true
        invalidateIntrinsicContentSize()
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        allText = textView.text
        firstLine = truncateString(toWidth: textView.frame.width - 23, withFont: textView.font!, text: textView.text)
        
        isEdinting = false
        invalidateIntrinsicContentSize()
        
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        isEdinting = true
        invalidateIntrinsicContentSize()
        return true
    }
}
