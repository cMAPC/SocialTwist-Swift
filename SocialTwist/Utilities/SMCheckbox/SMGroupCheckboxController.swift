//
//  SMGroupCheckboxController.swift
//  SMCheckBox
//
//  Created by Marcel  on 11/13/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import UIKit

class SMGroupCheckboxController: SMChecboxDelegate {
    
    var selectedCheckBox: Int!
    var haveSelection = false
    var checkboxesGroup = [SMCheckbox]()
    
    init(checkboxes: Array<SMCheckbox>) {
        checkboxesGroup = checkboxes
        for checkbox in checkboxes {
            checkbox.delegate = self
        }
    }
    
    func didChangeState(checkbox: SMCheckbox) {
        for (index, box) in checkboxesGroup.enumerated() {
            if box != checkbox {
                box.setCheckState(.unchacked)
            } else {
                selectedCheckBox = index
                haveSelection = true
            }
        }
    }
}
