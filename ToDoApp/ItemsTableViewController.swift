//
//  ItemsTableViewController.swift
//  ToDoApp
//
//  Created by TechFun on 04/03/2020.
//  Copyright © 2020 TechFunMyanmar. All rights reserved.
//

import UIKit
import Firebase

class ItemsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var user : User!
    var items = [Item]()
    var ref : DatabaseReference!
    private var databaseHandle : DatabaseHandle!

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        user = Auth.auth().currentUser
        ref = Database.database().reference()
        self.startObservingDatabase()
        // self of cell resize
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell" , for: indexPath) as! ItemTableViewCell
        let item = items[indexPath.row]
        cell.itemTitle.text = item.title
        cell.descripton.text = item.description
        return cell
        }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let item = items[indexPath.row]
            item.ref.removeValue()
        }
    }
   
    @IBAction func didTapSignOut(_ sender: UIBarButtonItem) {
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "SignOut", sender: nil)
        }catch{
            assertionFailure("Error signing out: \(error)")
        }
        
    }
    
    @IBAction func didTapAddItem(_ sender: UIBarButtonItem) {
        
        let prompt = UIAlertController(title: "To Do App", message: "To Do Item", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let userInputOfTitle = prompt.textFields![0].text
            let userInputOfDescription = prompt.textFields![1].text
            
            let items = [ "title" : userInputOfTitle , "description" : userInputOfDescription]
            if(userInputOfTitle!.isEmpty && userInputOfDescription!.isEmpty){
                return
            }
            self.ref.child("users").child(self.user.uid).child("items").childByAutoId().setValue(items)
         
        }
        
        prompt.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        prompt.addTextField { (textField) in
            textField.placeholder = "Add description"
        }
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
        
    }
    
    func startObservingDatabase(){
        
        databaseHandle = ref.child("users/\(self.user.uid)/items").observe(.value, with: { (snapshot) in
            var newItems = [Item]()
            for itemSnapShot in snapshot.children {
                let item = Item(snapshot: itemSnapShot as! DataSnapshot)
                newItems.append(item)
            }
            self.items = newItems
            self.tableView.reloadData()
        })
    }
    
//     deinit {
//          ref.child("users/\(self.user.uid)/items").removeObserver(withHandle: databaseHandle)
//      }
    
}
