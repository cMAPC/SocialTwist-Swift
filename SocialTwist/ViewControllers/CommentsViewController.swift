//
//  CommentsViewController.swift
//  SocialTwist
//
//  Created by Marcel  on 12/8/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit

class CommentsViewController: EventBaseViewController {
    
    // MARK: - Variables
    
    private let headerView: CommentsHeaderNode
    var interactionController: InteractorController?

    // MARK: - Object life cycle
    
    init() {
        headerView = CommentsHeaderNode()
        super.init(tableStyle: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.contentInset = UIEdgeInsetsMake(0, 0, 95, 0)
        headerView.delegate = self
        interactionController = InteractorController(viewController: self, tableView: tableNode.view)
    }
}

// MARK: - Table View Delegate

extension CommentsViewController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView.view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42.0
    }
}

// MARK: - Header Delegate

extension CommentsViewController: CommentsHeaderDelegate {
    func didTapDismissButton(sender: ASButtonNode) {
        dismiss(animated: true, completion: nil)
    }
}

