//
//  SubscribeTableViewCell.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 19/07/21.
//

import UIKit

class SubscribeTableViewCell: UITableViewCell {

    @IBOutlet weak var sub_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        sub_label.layer.cornerRadius = 10
        sub_label.clipsToBounds = true
        // Configure the view for the selected state
    }

}
