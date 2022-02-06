//
//  SolutionTableViewCell.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 24/06/21.
//
//
//Done Likes
import UIKit
import Firebase

class SolutionTableViewCell: UITableViewCell {
    
    let refreshControl = UIRefreshControl()
    
    var db = Firestore.firestore()
    
    //let send = SolutionViewController();
    
    var like_flag = 0;
    
    var lik_count = 0;
    
    var email = "";
    
    var ID = "";
    
    var SID = "";
    
    var langName = "";
    
    var get_like_db = 0;
    
    var cpy = 0;
    
    @IBOutlet weak var content_view_display: UIView!
    
    @IBOutlet weak var table_C_label: UILabel!
    
    @IBOutlet weak var s_view_display: UIView!
    
    
    @IBOutlet weak var just_like_label: UILabel!
    @IBOutlet weak var solution_label: UILabel!
    
    @IBOutlet weak var s_like_tapped: UIButton!
    
    @IBOutlet weak var s_like_label: UILabel!
    
    
    @IBAction func s_like_btn(_ sender: Any)
    {
        //fetchLikes()
        //displayLikes()
        
        //ID = UserDefaults.standard.string(forKey: "sid")!;
        //get_like_db = UserDefaults.standard.double(forKey: "likes")
        //fetchLikes()
    }
    /*
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        //table_view.reloadData()
        print("Its refreshing")
        refreshControl.endRefreshing()
    }
 */
    
    @objc func doubleTapped()
    {
        
        //displayLikes()
        
        //get_like_db = UserDefaults.standard.double(forKey: "likes")
        
        print("cellLikes: \(get_like_db)")
        print("Solution ID: \(ID)");
        //cpy = get_like_db;
        
        //updateLikes()
        //fetchDoubleLikes()
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        //refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        fetchLikes()
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "disconnectPaxiSockets"), object: nil)
        
       
        
        //langName = UserDefaults.standard.string(forKey: "language")!
        //print(ID);
        //print(get_like_db)
        //print(get_like_db);
        //print(langName)
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        s_view_display.layer.cornerRadius = 10;
        s_view_display.layer.borderWidth = 1;
        s_view_display.clipsToBounds = true;
        
        
        ID = UserDefaults.standard.string(forKey: "id")!;
        langName = UserDefaults.standard.string(forKey: "language")!
        //get_like_db = UserDefaults.standard.double(forKey: "likes")
    
        
        email = UserDefaults.standard.string(forKey: "email")!
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2;
        contentView.addGestureRecognizer(tap)
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
   
    
    
    func fetchLikes()
    {
        //let status = UserDefaults.standard.bool(forKey: "status")
        let username = UserDefaults.standard.string(forKey: "username")

        let userID = UserDefaults.standard.string(forKey: "userId")
        
        print("Going inside featch function")
        
        
        if(like_flag == 0)// false
        {
            
            s_like_tapped.setImage(UIImage(named: "heart_fill")?.withTintColor(.red),  for: .normal )
            //updataLikes()
            //print(ID)
            like_flag = 1
            get_like_db = get_like_db + 1
            s_like_label.text = String(get_like_db)
            
            SID = UserDefaults.standard.string(forKey: "sid")!
            print("Solution ID: \(SID)")
            //ID = UserDefaults.standard.string(forKey: "sid")!
            
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).updateData(["Likes":get_like_db, "Status":true])
            
            
            //updating likes in User>USolution
            
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).getDocument { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    let uname = snapshot?.get("Username") as? String ?? "No username"
                    print("Uname: \(uname)")
                    /*
                    if(uname! == username!)
                    {
                        self.db.collection(self.email).document(username! + " ID: " + userID!).collection("USolution").document("Solution ID: " + self.SID).updateData(["Likes":self.get_like_db, "Status":true])
                    }
                    */
                   
                }
                else
                {
                    print("Not going inside")
                }
            }
            
            
            //db.collection(email).document(username! + " ID: " + userID!).collection("USolution").whereField("Type", isEqualTo: "Solution").getDocuments(completion: )
            
            //if()
            //db.collection(email).document(username! + " ID: " + userID!).collection("USolution").document("Solution ID: " + SID).updateData(["Likes":get_like_db, "Status":true])
            
            
            
            
            
            
            //lik_count = lik_count + 1;
            
            
            /*
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + ID).getDocument { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    self.get_like_db = snapshot?.get("Likes") as? Double ?? 0.20
                    self.s_like_label.text = String(self.get_like_db)
                    print(self.get_like_db)
                    
                }
            }
             */
            
            
            
            
        }
        else //True
        {
            
            s_like_tapped.setImage(UIImage(named: "heart_outline"), for: .normal )
            //updataLikes()
            print("ID: \(ID)")
            
            like_flag = 0
            get_like_db = get_like_db - 1
            
            s_like_label.text = String(get_like_db)
            
            //ID = UserDefaults.standard.string(forKey: "sid")!
            SID = UserDefaults.standard.string(forKey: "sid")!
            print("Solution ID: \(SID)")
            
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).updateData(["Likes":get_like_db, "Status":false])
            
            
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).getDocument { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    let uname = snapshot?.get("Username") as? String
                    if(uname! == username!)
                    {
                        self.db.collection(self.email).document(username! + " ID: " + userID!).collection("USolution").document("Solution ID: " + self.SID).updateData(["Likes":self.get_like_db, "Status":true])
                    }
                   
                }
            }
            
            //lik_count = lik_count - 1
            //get_like_db = get_like_db - 1
            
            /*
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + ID).getDocument { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    self.get_like_db = snapshot?.get("Likes") as? Double ?? 0.20
                    self.s_like_label.text =  String(self.get_like_db)
                    print(self.get_like_db)
                    
                }
            }
             */
            
            
        }
        
        
        
        /*
        db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: \(ID)").getDocument { (snapshot, error) in
            
            if(error == nil && snapshot != nil)
            {
                self.get_like_db = snapshot?.get("Likes") as? Double ?? 0.0
                
                if(self.like_flag == 0)
                {
                    self.s_like_tapped.setImage(UIImage(named: "heart_fill")?.withTintColor(.red),  for: .normal )
                    //updataLikes()
                    print(self.get_like_db)
                    //like_flag = 1
                    //lik_count = lik_count + 1;
                    self.s_like_label.text = String(self.get_like_db)
                    
                }
                else
                {
                    self.s_like_tapped.setImage(UIImage(named: "heart_outline"), for: .normal )
                    //updataLikes()
                    print(self.get_like_db)
                    //like_flag = 0
                    //lik_count = lik_count - 1
                    self.s_like_label.text = String(self.get_like_db)
                }
            }
        }
         */
        
    }
    func updateLikes()
    {
        /*
        if(like_flag == 0)
        {
            get_like_db = get_like_db + 1.0
            
            print(langName)
            print("Solution ID: " + ID)
            print(get_like_db)
            
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + ID).updateData(["Likes":get_like_db])
            
            fetchLikes()
        }
        else
        {
            get_like_db = get_like_db - 1.0
            
            print(langName)
            print("Solution ID: " + ID)
            print(get_like_db)
            
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + ID).updateData(["Likes":get_like_db])
            
            fetchLikes()
        }
       */
        
    }
   
    
    
}
