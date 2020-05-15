//
//  LoginViewController.swift
//  ToDoApp
//
//  Created by TechFun on 04/03/2020.
//  Copyright © 2020 TechFunMyanmar. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCrashlytics


class LoginViewController: UIViewController {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = Auth.auth().currentUser{
            self.signIn()
        }
    }
    

    @IBAction func didTapSignIn(_ sender: UIButton) {
        //fatalError()// to test force crash of firebase crashlytics
        let email = emailField.text
        let password = passwordField.text
        Auth.auth().signIn(withEmail: email!, password: password! , completion: { (user , error) in
            guard let _ = user else {
                 if let error = error {
                    if let errCode = AuthErrorCode(rawValue: error._code){
                        switch errCode {
                        case .userNotFound:
                            self.showAlert("User account not found.Try again")
                        case .wrongPassword:
                             self.showAlert("Incorrect username/password combination")
                        default:
                            self.showAlert("Error : \(error.localizedDescription)")
                        }
                    }
                    return
                }
                assertionFailure("User and error are nil")
                return
            }
            self.signIn()
        })
    }
    
    @IBAction func didRequestForgotPwd(_ sender: UIButton) {
        
        let prompt = UIAlertController(title: "To Do App", message: "Email:", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
        let userInput = prompt.textFields![0].text
        if (userInput!.isEmpty) {
                       return
            }
            Auth.auth().sendPasswordReset(withEmail: userInput! , completion : { (error) in
                if let error = error{
                    if let errCode = AuthErrorCode(rawValue: error._code){
                        switch errCode {
                        case .userNotFound:
                            DispatchQueue.main.async {
                                self.showAlert("User account not found. Try again")
                            }
                        default :
                            DispatchQueue.main.async {
                                self.showAlert("Error: \(error.localizedDescription)")
                            }
                        }
                    }
                    return
                }else {
                    DispatchQueue.main.async {
                        self.showAlert("You'll receive an email shortly to reset your password.")
                    }
                }
            })
    }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
    
    }
    
    @IBAction func signUP(_ sender : UIButton){
        
        performSegue(withIdentifier: "goToSignUp", sender: self)
    }
    
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "To Do App", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    func signIn() {
        performSegue(withIdentifier: "SignInFromLogin", sender: nil)
    }
    
    
    
}
