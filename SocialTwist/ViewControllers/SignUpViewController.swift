//
//  SignUpViewController.swift
//  SocialTwist
//
//  Created by Marcel  on 10/17/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet var textFieldCollection: [UITextField]!
    @IBOutlet var checkboxCollection: [SMCheckbox]!
    
    private var groupCheckbox: SMGroupCheckboxController!
    private let sexes = ["M", "F", "C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthdayTextField.inputView = datePicker()
        groupCheckbox = SMGroupCheckboxController(checkboxes: self.checkboxCollection)
    }

    // MARK: - Action's
    
    @IBAction func signUp(_ sender: Any) {
        var allAreEmpty = true

        for textField in textFieldCollection {
            if textField.isEmpty {
                textField.showWarning()
            } else {
                allAreEmpty = false
            }
        }

        if allAreEmpty == true {
            AlertManager.showAlert(title: "Alert", message: "Complete all the fields")
        } else if nameTextField.isEmpty  {
            AlertManager.showAlert(title: "Alert", message: "Please, enter your name")
        } else if surnameTextField.isEmpty {
            AlertManager.showAlert(title: "Alert", message: "Please, enter your surname")
        } else if emailTextField.isEmpty {
            AlertManager.showAlert(title: "Alert", message: "Please, enter your email")
        } else if passwordTextField.isEmpty {
            AlertManager.showAlert(title: "Alert", message: "Please, enter your password")
        } else if !passwordTextField.text!.isPasswordValid {
            AlertManager.showAlert(title: "Alert", message: "Password must contain a special symbol, letters and a lenth biger then 8")
        } else if confirmPasswordTextField.isEmpty {
            AlertManager.showAlert(title: "Alert", message: "Please, confirm your password")
        } else if passwordTextField.text != confirmPasswordTextField.text {
            AlertManager.showAlert(title: "Alert", message: "Passwords don't match, Try again!")
        } else if birthdayTextField.isEmpty {
            AlertManager.showAlert(title: "Alert", message: "Please, enter your birthday")
        } else if !groupCheckbox.haveSelection {
            AlertManager.showAlert(title: "Alert", message: "Please, enter your sex")
        } else {

            let birthday = birthdayTextField.text!.toStringDate(fromDateFormat: "dd MMM yyyy", toDateFormat: "yyyy-MM-dd")

            RequestManager.signUp(name: nameTextField.text!,
                                  surname: surnameTextField.text!,
                                  email: emailTextField.text!,
                                  password: passwordTextField.text!,
                                  birthday: birthday,
                                  sex: sexes[groupCheckbox.selectedCheckBox],
                                  completition: { response in
                print(response)

            }, fail: { error in
                AlertManager.showAlert(title: "Alert", message: error as! String)
            })
        }
        
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - DatePicker
    
    func datePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = UIColor.white
        datePicker.addTarget(self, action: #selector(dateDidChange(_:)), for: .valueChanged)
        return datePicker
    }
    
    @objc func dateDidChange(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        birthdayTextField.text = dateFormatter.string(from: sender.date)
    }
}

// MARK: - UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.dismissWarning()
        return true
    }
}

