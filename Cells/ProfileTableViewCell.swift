//
//  ProfileTableViewCell.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 21/06/21.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var company_name_label: UILabel!
    
    @IBOutlet weak var cv: UIView!
    
    @IBOutlet weak var logout_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*
        cv.layer.cornerRadius = 10
        cv.layer.shadowOffset = CGSize(width: 5, height: 5)
        cv.layer.shadowRadius = 10
        cv.layer.shadowOpacity = 0.3
        */
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
