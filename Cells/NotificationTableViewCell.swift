//
//  NotificationTableViewCell.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 14/07/21.
//

import UIKit

//MARK:- NotificationViewCell
class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var notification_label: UILabel!
    
    @IBOutlet weak var view_deign: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view_deign.layer.cornerRadius = 10
        view_deign.clipsToBounds = true
        
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.3
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
