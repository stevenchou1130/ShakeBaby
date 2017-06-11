//
//  GroupResultTableViewCell.swift
//  ShakeBaby
//
//  Created by 孟軒蕭 on 10/06/2017.
//  Copyright © 2017 stevenchou. All rights reserved.
//

import UIKit

class GroupResultTableViewCell: UITableViewCell {

    @IBOutlet weak var rank: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var shakeCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
