//
//  SaveTableViewCell.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 09/07/21.
//

import UIKit
import Firebase

class SaveTableViewCell: UITableViewCell,UIAlertViewDelegate {
    
    @IBOutlet weak var save_view_design: UIView!
    
    @IBOutlet weak var save_error_label: UILabel!
    
    @IBOutlet weak var save_solution_label: UILabel!
    
    @IBOutlet weak var posted_by: UILabel!
    
    @IBOutlet weak var posted_on: UILabel!
    
    @IBOutlet weak var saved_on: UILabel!
    
    @IBOutlet weak var save_flag_save: UIButton!
    
    var db = Firestore.firestore()
    
    @objc func doubleTapped()
    {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "DoubleTapped"), object: nil)
        /*
        let email = UserDefaults.standard.string(forKey: "email")
        let u_sername = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        print("D Tapped")
        let saveFID = UserDefaults.standard.string(forKey: "savefid")
        
        let alert = UIAlertController(title: "Un-save", message: "Do you want to un-save?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            self.db.collection(email!).document(u_sername! + " ID: " + userID!).collection("Save").document("Save ID: " + saveFID!).delete()
        }))
        alert.addAction(UIAlertAction(title: "N0", style: .default, handler: nil))
        
        self.
        */
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        save_view_design.layer.cornerRadius = 10
        //save_view_design.layer.borderWidth = 1
        save_view_design.clipsToBounds = true
        
        
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.3
       
        save_flag_save.setImage(UIImage(named: "saveFilled")?.withTintColor(.blue), for: .normal)
        
        
        //let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        
        //tap.numberOfTapsRequired = 2;
        //contentView.addGestureRecognizer(tap)
        
        
        //dropShadow()
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    /*
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //contentView.dropShadow()
        //contentView.dropShadow(scale: true)

        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        
        
        
               
        
    }
     */
    

}

extension UIView{
    func dropShadow(scale: Bool = true)
    {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 0.5
        
        layer.shadowPath = UIBezierPath(rect:bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale:1
        
    }
    
    
}
