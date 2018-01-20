//
//  CommentsViewController.swift
//  SocialTwist
//
//  Created by Marcel  on 12/4/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import UIKit
import AsyncDisplayKit

class EventBaseViewController: ASViewController<ASTableNode> {

    // MARK: - Variables
    
    var comments = [Comment]()
    
    // MARK: - Constants
    
    var tableNode: ASTableNode!
    var stickyInputView: InputAccessoryView?
    
    // MARK: - Object life cycle

    enum TableStyle {
        case grouped
        case plain
    }
    
    init(tableStyle: TableStyle) {
        stickyInputView = InputAccessoryView()
        tableStyle == .grouped ? (tableNode = ASTableNode.init(style: .grouped)) : (tableNode = ASTableNode())
        super.init(node: tableNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.backgroundColor = UIColor.TwistPalette.FlatGray
        tableNode.allowsSelection = false
        tableNode.view.separatorStyle = .none
        tableNode.dataSource = self
        tableNode.delegate = self
        tableNode.leadingScreensForBatching = 2.5
        tableNode.view.keyboardDismissMode = .interactive
        
        stickyInputView?.delegate = self
    }
    
    // MARK: Accessory View
    
    override var inputAccessoryView: UIView? {
        return stickyInputView
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
   
    // MARK: - Helpers
    
    func fetchNewBatchWithContext(_ context: ASBatchContext) {
        RequestManager.getDogsImages(completion: { response in
            for (index, imagerUrl) in (response as! [String]).enumerated() {
                let comment = Comment(creatorPictureURL: imagerUrl,
                                      creatorName: "Spinu Marcel",
                                      comment: "Comment, Comment, Comment, Comment, Comment, Comment",
                                      date: "20.10.2018")
                self.comments.append(comment)
            }
            self.tableNode.reloadData()
        }) { error in
            print(error)
        }
    }
}

// MARK: - ASTableDataSource, ASTableDelegate

extension EventBaseViewController: ASTableDataSource, ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let comment = comments[indexPath.row]
        
        return {
            return CommentCellNode(comment: comment)
        }
    }
     
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        fetchNewBatchWithContext(context)
    } 
}

// MARK: - Input Accessory Delegate

extension EventBaseViewController: InputAccessoryDelegate {
    func didFinishEditing() {
        
    }
}

