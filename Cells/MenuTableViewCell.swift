//
//  MenuTableViewCell.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 07/06/21.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var lable: UILabel!
    
    @IBOutlet weak var view_label: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        view_label.layer.cornerRadius = 10;
        view_label.layer.borderWidth = 1
        view_label.clipsToBounds = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
