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
import ImageViewer
import SimpleImageViewer

class TimelineViewController: UIViewController {
    
    var tableNode: ASTableNode?
    var events = [Event]()
    
    var imagePicker: UIImagePickerController!
    
    
    var imagesUrls = [String]()
    var guests = [Friend]()
    
//    let interactor = InteractorController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDogs()
        
        tableNode = ASTableNode(style: .plain)
        tableNode?.view.keyboardDismissMode = .interactive
        view.addSubnode(tableNode!)

        wireDelegation()
        
        imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        navigationItem.backBarButtonItem = UIBarButtonItem.backButtonItemWithoutTitle
    
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableNode?.frame = view.bounds
    }
    
    func wireDelegation() {
//        tableNode?.delegate = self
        tableNode?.dataSource = self
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
                                  description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                  place: "Chisinau Chisinau Chisinau Chisinau",
                                  attenders: 20,
                                  startTime: "1534941142",
                                  type: "")
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
    
    
    
    //-----------------------------------------
    // MARK: - DateTime Picker
    //-----------------------------------------
    
    func showDateTimePicker(completion: ((Date)->Void)?) {
        /*
        let min = Date() //Date().addingTimeInterval(-60 * 60 * 24 * 4)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 60)
        let picker = DateTimePicker.show(selected: Date(), minimumDate: min, maximumDate: max)
        
        picker.timeInterval = DateTimePicker.MinuteInterval.five
        picker.highlightColor = UIColor.TwistPalette.FlatBlue
        picker.darkColor = UIColor.darkGray
        picker.doneButtonTitle = "Done"
        picker.doneBackgroundColor = UIColor.TwistPalette.FlatBlue
        picker.locale = Locale(identifier: "en_GB")
        
        picker.todayButtonTitle = ""
        picker.is12HourFormat = false
        picker.dateFormat = "d MMMM, h:mm aa"
        picker.includeMonth = true
        
        picker.completionHandler = { date in
            completion?(date)
        }
         */
        
        let min = Date()
        let max = Date().addingTimeInterval(60 * 60 * 24 * 60)
        let picker = DateTimePicker.show(selected: Date(), minimumDate: min, maximumDate: max)
        
        // Picker style
        picker.dateFormat = "d MMMM, h:mm aa"
        picker.includeMonth = true
        picker.highlightColor = UIColor.TwistPalette.FlatBlue
        picker.doneBackgroundColor = UIColor.TwistPalette.FlatBlue
        picker.doneButtonTitle = "Done"
        
        // Picker constraints
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.addConstraint(NSLayoutConstraint(item: picker,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: nil,
                                                attribute: .notAnAttribute,
                                                multiplier: 1,
                                                constant: 235))
        
        // Alert controller
        let alert = UIAlertController(title: "Choose event date",
                                      view: picker,
                                      fallbackMessage: "This should be a red rectangle",
                                      preferredStyle: .actionSheet)
        
        // Alert style
        alert.view.isOpaque = false
        alert.view.backgroundColor = UIColor.white
        alert.view.layer.cornerRadius = 15
        
        present(alert, animated: true) {
            alert.view.superview?.subviews.first?.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapAlertControllerBackground(_:)))
            alert.view.superview?.subviews.first?.addGestureRecognizer(tapGesture)
        }
        
        picker.completionHandler = { date in
            completion?(date)
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    //-----------------------------------------
    // MARK: - Event type Picker
    //-----------------------------------------
    
    func showEventCategoryPicker(completion: ((String)->Void)?) {
        
        let eventTypePicker = EventTypePicker.show()
        
        // Picker constraints
        eventTypePicker.translatesAutoresizingMaskIntoConstraints = false
        eventTypePicker.addConstraint(NSLayoutConstraint(item: eventTypePicker,
                                                           attribute: .height,
                                                           relatedBy: .equal,
                                                           toItem: nil,
                                                           attribute: .notAnAttribute,
                                                           multiplier: 1,
                                                           constant: 230))
        // Alert controller
        let alert = UIAlertController(title: "Choose event category",
                                      view: eventTypePicker,
                                      fallbackMessage: "This should be a red rectangle",
                                      preferredStyle: .actionSheet)
        
        // Alert style
        alert.view.isOpaque = false
        alert.view.backgroundColor = UIColor.TwistPalette.DarkGray
        alert.view.layer.cornerRadius = 15
        
        //        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        //        subview.backgroundColor = UIColor.TwistPalette.FlatBlue
        
        //        alert.view.tintColor = UIColor.red
        //        let attributedString = NSAttributedString(string: "Choose event category",
        //                                                  attributes: [.foregroundColor : UIColor.white])
        //        alert.setValue(attributedString, forKey: "attributedTitle")
        
        present(alert, animated: true) {
            alert.view.superview?.subviews.first?.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapAlertControllerBackground(_:)))
            alert.view.superview?.subviews.first?.addGestureRecognizer(tapGesture)
        }
        
        eventTypePicker.completionHandler = { value in
            completion?(value)
            alert.dismiss(animated: true, completion: nil)
        }
    }
 
    // MARK: - Alert controller
    @objc func didTapAlertControllerBackground(_: UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
}


//-----------------------------------------
// MARK: - Table View Delegate
//-----------------------------------------

extension TimelineViewController: ASTableDataSource, ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        if indexPath.row == 0 {
            return {
                let postNode = PostCellNode()
                postNode.event?.creatorImageURL = self.events[1].creatorImageURL // ????????????????????????
                postNode.reload() //////////// ?????????????????????????????????????????????
                postNode.delegate = self
                return postNode
            }
        } else {
            let event = events[indexPath.row]
            return {
                let node = EventCellNode(event: event)
                node.delegate = self
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
// MARK: - Event Cell Delegate
//-----------------------------------------

extension TimelineViewController: EventCellDelegate {
    func didTapEventImage(sender: EventCellNode, imageView: UIImageView) {
        let configuration = ImageViewerConfiguration { config in
            config.imageView = imageView
        }
        present(ImageViewerController(configuration: configuration), animated: true)
    }
    
    
    func didTapLikeButton(sender: ASButtonNode) {
        
    }
    
    func didTapDislikeButton(sender: ASButtonNode) {
        
    }

    func didTapCommentButton(sender: ASButtonNode) {        
        let commentsVC = CommentsViewController()
        commentsVC.transitioningDelegate = self
        commentsVC.modalPresentationStyle = .overCurrentContext
        present(commentsVC, animated: true, completion: nil)
    }
    
    func didTapEventDescriptionNode(event: Event) {
        let eventExtendetVC = EventExtendetViewController(event: event)
        navigationController?.pushViewController(eventExtendetVC, animated: true)
    }
}


//-----------------------------------------
// MARK: - Post Cell Delegate
//-----------------------------------------

extension TimelineViewController: PostCellDelegate {
    func didTapEventImage(sender: PostCellNode, imageView: UIImageView) {
        let configuration = ImageViewerConfiguration { config in
            config.imageView = imageView
        }
        present(ImageViewerController(configuration: configuration), animated: true)
    }
    
    func didTapCategoryButton(sender: PostCellNode) {
        showEventCategoryPicker { value in
            sender.event?.type = value
            sender.reload()
        }
    }
    
    func didTapDateTimeButton(sender: PostCellNode) {
        showDateTimePicker { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM YYYY, hh:mm aa"
            let timestamp = date.timeIntervalSince1970
            sender.event?.startTime = String(timestamp)
            sender.reload()
        }
    }
    
    func didTapPhotoButton(sender: ASButtonNode) {
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Take a photo", style: .default) { (completed) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let galleryAction = UIAlertAction(title: "Choose from gallery", style: .default) { (completed) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (completed) in
            
        }
        
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func didTapInviteButton(sender: ASButtonNode) {
        let inviteVC = InviteViewController()
        inviteVC.delegate = self
        inviteVC.inviteHeader.guests = self.guests
//        inviteVC.inviteHeader.collectionView.reloadData()
//        inviteVC.inviteHeaderHeight = 100
//        inviteVC.reload()
        navigationController?.pushViewController(inviteVC, animated: true)
    }
    
    func didTapPlaceButton(sender: PostCellNode) {
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .actionSheet)
        let currentPlaceAction = UIAlertAction(title: "Current place", style: .default) { (completed) in
            
            LocationPickerViewController.currentLocation()
            LocationPickerViewController.completion = { location in
                if let address = location?.address {
                    sender.event?.place = address
                    sender.reload()
                }
            }
        }
        
        let customPlaceAction = UIAlertAction(title: "Choose another place", style: .default) { (completed) in
            
            let locationPickerVC = LocationPickerViewController()
            locationPickerVC.mapType = .standard
            locationPickerVC.searchHistoryLabel = ""
            locationPickerVC.completion = { location in
                if let address = location?.address {
                    sender.event?.place = address
                    sender.reload()
                }
            }
            self.navigationController?.pushViewController(locationPickerVC, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (completed) in
            
        }
        
        alertController.addAction(currentPlaceAction)
        alertController.addAction(customPlaceAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

//-----------------------------------------
// MARK: - Invite VC Delegate
//-----------------------------------------

extension TimelineViewController: InviteViewControllerDelegate {
    func didSelectGuests(guests: [Friend]) {
        let indexPath = IndexPath(row: 0, section: 0)
        let postCell = tableNode?.nodeForRow(at: indexPath) as! PostCellNode
        print(guests.count)
        self.guests = guests
        postCell.event?.attenders = guests.count
        postCell.reload()
    }
}

//-----------------------------------------
// MARK: - Image Picker Delegate
//-----------------------------------------

extension TimelineViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let indexPath = IndexPath(row: 0, section: 0)
            let postCell = tableNode?.nodeForRow(at: indexPath) as! PostCellNode
            
            postCell.eventImageNode.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

//-----------------------------------------
// MARK: - Transition Delegate
//-----------------------------------------

extension TimelineViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return PresentAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let viewController = dismissed as? CommentsViewController else {
            return nil
        }
//        return DismissAnimationController()
        return DismissAnimationController(interactionController: viewController.interactionController)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? DismissAnimationController,
            let interactionController = animator.interactionController,
            interactionController.interactionInProgress
            else {
                return nil
        }
        return interactionController
        
//        return interactor.interactionInProgress ? interactor : nil
    }
}









