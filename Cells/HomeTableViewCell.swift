//
//  HomeTableViewCell.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 20/06/21.
//

import UIKit
import Firebase

//MARK:- Struct
struct Likes {
    var Likes : String
}
//MARK:- HomeTableViewcell
class HomeTableViewCell: UITableViewCell {
    
    var db = Firestore.firestore()
    
    var like_flag = 0;
    
    var lik_count = 0;
    
    var email = "";
    
    var saveLikes = [Likes]();
    
    
    
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var username_label: UILabel!
    
    @IBOutlet weak var profession_label: UILabel!
    
    @IBOutlet weak var e_label: UILabel!
    
    @IBOutlet weak var s_label: UILabel!
    
    @IBOutlet weak var posted_on: UILabel!
    
    @IBOutlet weak var cell_view_design: UIView!
    
    @IBOutlet weak var like_count: UILabel!
    
    @IBOutlet weak var like_btn_tapped: UIButton!
    
    @IBOutlet weak var image_label: UIImageView!
    
    @IBOutlet weak var H_like_btn_tapped: UIButton!
    
    
    @IBOutlet weak var H_like_label: UILabel!
    
    @IBAction func like_btn_action(_ sender: Any)
    {
        if(like_flag == 0)
        {
            H_like_btn_tapped.setImage(UIImage(named: "heart_fill")?.withTintColor(.red),  for: .normal )
            //updataLikes()
            
            //like_flag = 1
            //lik_count = lik_count + 1;
            H_like_label.text = String(lik_count)
            
        }
        else 
        {
            H_like_btn_tapped.setImage(UIImage(named: "heart_outline")?.withTintColor(.black), for: .normal )
            //updataLikes()
            
            //like_flag = 0
            //lik_count = lik_count - 1
            H_like_label.text = String(lik_count)
        }
        
    }
    
    
    
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        homeImg.layer.cornerRadius = 10;
        homeImg.clipsToBounds = true;
        cell_view_design.layer.cornerRadius = 10
        //cell_view_design.layer.borderWidth = 0.3;
        //cell_view_design.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        //cell_view_design.backgroundColor = .lightText
        cell_view_design.clipsToBounds = true
        //cell_view_design.layer.shadowOffset = CGSize(width: 10, height: 10)
        //cell_view_design.layer.shadowRadius = 5
        //cell_view_design.layer.shadowOpacity = 1
        //cell_view_design.layer.shadowColor = .init(red: 10, green: 10, blue: 10, alpha: 1)
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.3
        
        
        email = UserDefaults.standard.string(forKey: "email")!
        
        if(like_flag == 0)
        {
            like_btn_tapped.setImage(UIImage(named: "heart_outline")?.withTintColor(.systemBackground), for: .normal )
            //fetchLikes()
        }
        else
        {
            like_btn_tapped.setImage(UIImage(named: "heart_fill")?.withTintColor(.red), for: .normal )
            //fetchLikes()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //contentView.dropShadow()
        //contentView.dropShadow_()
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        
    }
    
    //MARK:- On double click
    func fetchLikes()
    {
        db.collection(email).document(email).collection("Solution").whereField("Type", isEqualTo: "Solution").getDocuments { (snapshot, error) in
            if(error == nil)
            {
                for documentData in snapshot!.documents
                {
                    let data = documentData.data()
                    let likes = data["SLikes"] as? String
                    let newLikes = Likes(Likes: likes!);
                    self.saveLikes.append(newLikes)
                    
                }
            }
            else
            {
                print("Error occured while fetching likes")
            }
        }
    }
    
    func updataLikes()
    {
        if(like_flag == 0)
        {
            like_flag = 1
            lik_count = lik_count + 1;
            
            
            db.collection(email).document(email).collection("Solution").whereField("Type", isEqualTo: "Solution").getDocuments { (snapshot, error) in
                if(error == nil)
                {
                    for documentData in snapshot!.documents
                    {
                        let data = documentData.data()
                        let likes = data["SLikes"] as? String
                        let newLikes = Likes(Likes: likes!);
                        self.saveLikes.append(newLikes)
                        
                    }
                }
                else
                {
                    print("Error occured while fetching likes")
                }
            }
            
            db.collection(email).document(email).collection("Solution").document().updateData(["SLikes":lik_count])
        }
        else
        {
            
            like_flag = 0
            lik_count = lik_count - 1
            
            db.collection(email).document(email).collection("Solution").document().updateData(["SLikes":lik_count])
        }
        
    }

}
/*
extension UIView{
    func dropShadow_(scale: Bool = true)
    {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect:bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale:1
        
    }
    
    
}
*/
