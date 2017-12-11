////
////  ExtendetEventViewController.swift
////  SocialTwist
////
////  Created by Marcel  on 12/8/17.
////  Copyright © 2017 Marcel . All rights reserved.
////
//
//import UIKit
//import AsyncDisplayKit
//
//class ExtendetEventViewController: EventBaseViewController {
//
//    // MARK: - Variables
//    
//    private let headerView: ExtendetEventHeaderNode
//    var event: Event
//    
//    // MARK: - Object life cycle
//    
//    init(event: Event) {
//        self.event = event
//        headerView = ExtendetEventHeaderNode(event: event)
//        super.init()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableNode.reloadData()
//    }
//    
//    
//    
//    override func viewWillLayoutSubviews() {
//        print("Size \(headerView.bounds.size.height)")
//    }
//}
//
//// MARK: - Table View Delegate
//
//extension ExtendetEventViewController {
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return headerView.view
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        
//        return headerView.calculatedSize.height
//    }
//}
//
