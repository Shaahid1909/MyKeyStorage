//
//  UserTableViewCell.swift
//  MyInfoStore
//
//  Created by Admin on 08/01/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let identifier = "UserDataCell"
    
    
    @IBOutlet var sourceLab: UILabel!
    @IBOutlet var userLab: UILabel!
    @IBOutlet var passLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
