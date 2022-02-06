//
//  HistoryTableViewCell.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 09/07/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var history_data_label: UILabel!
    
    @IBOutlet weak var history_view_design: UIView!
    
    @IBOutlet weak var posted_on: UILabel!
    
    @IBOutlet weak var u_likes: UILabel!
    
    @IBOutlet weak var activity_label: UILabel!
    
    @IBOutlet weak var error_history_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        history_view_design.layer.cornerRadius = 10
        //history_view_design.layer.borderWidth = 1
        history_view_design.clipsToBounds = true
        
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
