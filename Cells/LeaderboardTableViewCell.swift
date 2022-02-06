//
//  LeaderboardTableViewCell.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 12/07/21.
//

import UIKit

//MARK:- Cell
class LeaderboardTableViewCell: UITableViewCell {

    
    @IBOutlet weak var view_design: UIView!
    @IBOutlet weak var rank_label: UILabel!
    
    @IBOutlet weak var name_label: UILabel!
    
    @IBOutlet weak var position_label: UILabel!
    
    @IBOutlet weak var likes_label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view_design.layer.cornerRadius = 10
        view_design.clipsToBounds = true
        
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
