//
//  ItemTableViewCell.swift
//  ToDoApp
//
//  Created by TechFun on 10/03/2020.
//  Copyright © 2020 TechFunMyanmar. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemTitle: UILabel!
       
    @IBOutlet weak var descripton: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
