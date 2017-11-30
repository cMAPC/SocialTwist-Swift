//
//  TimelineViewController.swift
//  SocialTwist
//
//  Created by Marcel  on 11/22/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import UIKit
import CoreLocation
import AsyncDisplayKit

class TimelineViewController: UIViewController {

    var tableNode: ASTableNode?
    var events = [Event]()
    
    
    let locationManager = CLLocationManager()
    var imagesUrls = [String]()
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDogs()
        
        tableNode = ASTableNode(style: .plain)
        view.addSubnode(tableNode!)

        wireDelegation()
        
        imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableNode?.frame = view.bounds
    }
    
    func wireDelegation() {
//        tableNode?.delegate = self
        tableNode?.dataSource = self
    }
    
    @IBAction func getEventsButton(_ sender: Any) {

    }
    
    func getDogs() {
        RequestManager.getDogsImages(completion: { response in
            self.imagesUrls = response as! [String]
            
            for (index, imagerUrl) in (response as! [String]).enumerated() {
                var imagerUr: String
                if index % 2 == 0 {
                    imagerUr = ""
                } else {
                    imagerUr = imagerUrl
                }
                let event = Event(imageURL: imagerUr,
                                creatorImageURL: imagerUrl,
                                creatorName: "Marcel Spinu",
                                description: "Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description",
                                place: "Chisinau Chisinau Chisinau Chisinau")
                self.events.append(event)
            }
            self.tableNode?.reloadData()
        }) { error in
            print(error)
        }
    }
    
    
    
    
    
    func getEvents() {
        /*
         locationManager.requestAlwaysAuthorization()
         locationManager.requestWhenInUseAuthorization()
         
         if CLLocationManager.locationServicesEnabled() {
         locationManager.startUpdatingLocation()
         }
         
         let categories = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
         
         
         let coordinates = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!,
         longitude: (locationManager.location?.coordinate.longitude)!)
         
         RequestManager.getEvents(coordinates: coordinates,
         radius: 1,
         categories: categories,
         offset: 0,
         count: 100,
         completion: { response in
         
         print(response)
         }) { error in
         print(error)
         }
         */
    }
}


//-----------------------------------------
// MARK: - UITableViewDataSource
//-----------------------------------------

extension TimelineViewController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        if indexPath.row == 0 {
            let event = events[indexPath.row]
            return {
                let postNode = PostCellNode(event: event)
                postNode.delegate = self
                return postNode
            }
        } else {
            let event = events[indexPath.row]
            return {
                let node = EventCellNode(event: event)
                return node
            }
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let min = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/3.0 * 2.0)
        let max = CGSize(width: UIScreen.main.bounds.size.width, height: CGFloat.greatestFiniteMagnitude)
        return ASSizeRange(min: min, max: max)
    }
}

//-----------------------------------------
// MARK: - PostCellDelegate
//-----------------------------------------

extension TimelineViewController: PostCellDelegate {
    func didTapPhotoButton(sender: ASButtonNode) {
        present(imagePicker, animated: true, completion: nil)
    }
}

//-----------------------------------------
// MARK: - UIImagePickerControllerDelegate
//-----------------------------------------

extension TimelineViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let indexPath = IndexPath(row: 0, section: 0)
            let postCell = tableNode?.nodeForRow(at: indexPath) as! PostCellNode
            
            postCell.eventImage = image
        }
        dismiss(animated: true, completion: nil)
    }
}















//extension TimelineViewController: PostCellDelegate {
//    func editableTextNodeDidChange(sender: ASEditableTextNode) {
//        tableNode?.performBatchUpdates({
//
////            print("Frame befor: \(sender.frame)")
////
////            var frame = sender.frame
////            frame.size.height += 10
////            sender.frame = frame
//
//            print("Frame after: \(sender.frame)")
//
//        }, completion: { (result) in
//
//        })
//    }
//}


/*
// MARK: - UITableViewDelegate

extension TimelineViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        nextPageWithCompletion { (results) in
            self.insertNewRows(results)
            context.completeBatchFetching(true)
        }
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
}

// MARK: - Helpers

extension TimelineViewController {
    func nextPageWithCompletion(_ block: @escaping (_ results: [Event]) -> ()) {
//        if let dogsArray = self.dogs {
//            let moreAnimals = Array(self.dogs[0 ..< 5])
//            DispatchQueue.main.async {
//                block(moreAnimals)
//            }
//        }
        
    }
    
    func insertNewRows(_ newAnimals: [Event]) {
        let section = 0
        var indexPaths = [IndexPath]()
        
        let newTotalNumberOfPhotos = events.count + newAnimals.count
        
        for row in events.count ..< newTotalNumberOfPhotos {
            let path = IndexPath(row: row, section: section)
            indexPaths.append(path)
        }
        
        events.append(contentsOf: newAnimals)
//        if let tableNode = node as? ASTableNode {
        tableNode?.insertRows(at: indexPaths, with: .none)
//        }
    }
}

*/

