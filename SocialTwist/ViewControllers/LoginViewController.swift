//
//  LoginViewController.swift
//  SocialTwist
//
//  Created by Marcel  on 10/16/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action's
    
    @IBAction func signIn(_ sender: Any) {
        
        if emailTextField.isEmpty {
            AlertManager.showAlert(title: "Alert", message: "Please, enter your email")
            emailTextField.showWarning()
        } else if passwordTextField.isEmpty {
            AlertManager.showAlert(title: "Alert", message: "Please, enter your password")
            passwordTextField.showWarning()
        } else {
            RequestManager.signIn(email: emailTextField.text!, password: passwordTextField.text!, completition: { response in
                print(response)
            }, fail: { error in
                AlertManager.showAlert(title: "Error Signing In", message: "The user name or password is incorrect")
            })
        }
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.dismissWarning()
        return true
    }
}
