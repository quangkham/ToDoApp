//
//  SignUpViewController.swift
//  ToDoApp
//
//  Created by TechFun on 04/03/2020.
//  Copyright © 2020 TechFunMyanmar. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapCreateAccount(_ sender: UIButton) {
        let email = emailTextField.text
        let password = passwordTextField.text
        passwordTextField.textContentType = .newPassword
        passwordTextField.isSecureTextEntry = true
        
        Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user , error )in
            if let error = error {
                if let errCode = AuthErrorCode(rawValue: error._code){
                    switch errCode{
                    case .invalidEmail:
                        self.showAlert("Enter a valid email")
                    case .emailAlreadyInUse:
                        self.showAlert("Email already in use")
                    default :
                        self.showAlert("Error: \(error.localizedDescription)")
                    }
                }
                return
            }
            self.signIn()
        })
    }
    
    
    
    @IBAction func didTapSignIn(_ sender: UIButton) {
         self.dismiss(animated: true, completion: {})
        
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "To Do App", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func signIn() {
        performSegue(withIdentifier: "SignInFromSignUp", sender: nil)
    }
}
