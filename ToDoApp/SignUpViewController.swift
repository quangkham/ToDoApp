//
//  SignUpViewController.swift
//  ToDoApp
//
//  Created by TechFun on 04/03/2020.
//  Copyright © 2020 TechFunMyanmar. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapCreateAccount(_ sender: UIButton) {
    }
    
    
    @IBAction func didTapSignIn(_ sender: UIButton) {
         self.dismiss(animated: true, completion: {})
    }
}
