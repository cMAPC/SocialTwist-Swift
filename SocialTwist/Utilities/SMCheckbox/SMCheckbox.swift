//
//  SMCheckbox.swift
//  SMCheckBox
//
//  Created by Marcel  on 10/30/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import UIKit

//-----------------------------
// MARK: - Protocols
//-----------------------------



protocol SMChecboxDelegate {
    
    func didChangeState(checkbox: SMCheckbox) -> Void
}

class SMCheckbox: UIControl {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //-----------------------------
    // MARK: - Properties
    //-----------------------------
    
    var delegate: SMChecboxDelegate?
    var checkState: CheckState = .unchacked
    var boxLineWidth: CGFloat = 1.0
    var boxStrokeColor = UIColor.TwistPalette.FlatGray.cgColor
    var boxFillColor = UIColor.clear.cgColor
    var checkmarkFillColor = UIColor.TwistPalette.FlatBlue.cgColor
    
    
    //-----------------------------
    // MARK: - Constants
    //-----------------------------

    private let pathController = SMCheckboxPathController()
    private let animationController = SMCheckboxAnimationController()
    private let boxLayer = CAShapeLayer()
    private let markLayer = CAShapeLayer()
    
    public enum CheckState: String {
        case unchacked = "Unchecked"
        case checked = "Checked"
    }

    //-----------------------------
    // MARK: - Initialization
    //-----------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedSetup()
    }
    
    func sharedSetup() -> Void {
        self.backgroundColor = UIColor.clear
        
        pathController.size = min(frame.size.width, frame.size.height)
        pathController.boxLineWidth = boxLineWidth
        
        setupBoxLayer()
        setupCheckmarkLayer()
        
        let longPressGesture = UILongPressGestureRecognizer (target: self, action: #selector(handleLongPress(_:)))
        longPressGesture.minimumPressDuration = 0.0
        addGestureRecognizer(longPressGesture)
    }
    
    func setupBoxLayer() {
        boxLayer.lineWidth = boxLineWidth
        boxLayer.strokeColor = boxStrokeColor
        boxLayer.fillColor = boxFillColor
        boxLayer.path = pathController.pathForCircle().cgPath
        self.layer.addSublayer(boxLayer)
    }
    
    func setupCheckmarkLayer() {
        markLayer.fillColor = checkmarkFillColor
        markLayer.path = pathController.pathForMark().cgPath
        markLayer.frame = CGRect (x: 0.0, y: 0.0, width: self.frame.height, height: self.frame.height)
        markLayer.opacity = 0.0
        self.layer.addSublayer(markLayer)
    }
    
    //-----------------------------
    // MARK: - UIControl
    //-----------------------------
    
    @objc func handleLongPress(_ sender: UILongPressGestureRecognizer) -> Void {
        if sender.state == .began || sender.state == .changed {
            isSelected = true
        } else {
            isSelected = false
            if sender.state == .ended {
                toggleCheckState()
                sendActions(for: .valueChanged)
            }
        }
    }
    
    //-----------------------------
    // MARK: - State
    //-----------------------------
    
    func setCheckState(_ newState: CheckState) -> Void {
        if checkState == newState {
            return
        } else {
            checkState = newState
        }
        
        if checkState == .checked {
            markLayer.opacity = 1.0
            let animation = animationController.fillAnimation(key: "transform", reverse: false)
            markLayer.add(animation, forKey: "transform")
        } else {
            let animation = animationController.fillAnimation(key: "transform", reverse: true)
            markLayer.add(animation, forKey: "transform")
        }
    }
    
    func toggleCheckState() -> Void {
        switch checkState {
        case .checked:
            setCheckState(.unchacked)
            break
        case .unchacked:
            setCheckState(.checked)
            break
        }
        delegate?.didChangeState(checkbox: self)
    }
}
