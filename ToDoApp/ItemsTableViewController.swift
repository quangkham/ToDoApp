//
//  ItemsTableViewController.swift
//  ToDoApp
//
//  Created by TechFun on 04/03/2020.
//  Copyright © 2020 TechFunMyanmar. All rights reserved.
//

import UIKit

class ItemsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
 
    

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = UITableViewCell()
         return cell;
     }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

   
    @IBAction func didTapSignOut(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func didTapAddItem(_ sender: UIBarButtonItem) {
    }
    
}
