//
//  NewSolutionTableViewCell.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 28/06/21.
//

import UIKit
import Firebase
//MARK:- Structure
struct  NTotalLikes {
    var Likes : Int
}
//MARK:- NewSolutionTableViewCell
class NewSolutionTableViewCell: UITableViewCell {

    
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
    
    var save_btn_flag = 0
    
    var xyzlikes = 0
    
    var structNTotalLikes = [NTotalLikes]()

    //var sumLikes = 0
    
    @IBOutlet weak var update_view: UIView!
    
    @IBOutlet weak var upheight: NSLayoutConstraint!
    
    @IBOutlet weak var content_view_s: UIView!
    
    @IBOutlet weak var s_view_display: UIView!
    
    @IBOutlet weak var data_label: UILabel!
    
    @IBOutlet weak var likes_label: UILabel!
    
    @IBOutlet weak var like_btn_Llabel: UIButton!
    
    @IBOutlet weak var save_btn_label: UIButton!
    
    @IBOutlet weak var s_username_label: UILabel!
    
    @IBOutlet weak var s_profession_label: UILabel!
    
    @IBOutlet weak var posted_on: UILabel!
    
    @IBOutlet weak var solImg: UIImageView!
    
    //bookmark
    //bookmark.fill bookmark.fill
    /*
    @IBAction func save_btn(_ sender: Any)
    {
        print("saved button called")
        if(save_btn_flag == 0)
        {
            save_btn_label.setImage(UIImage(named: "bookmark"), for: .normal)
            save_btn_flag = 1;
        }
        else
        {
            save_btn_label.setImage(UIImage(named: "bookmark.fill")?.withTintColor(.black), for: .normal)
            save_btn_flag = 0;
        }
    }
    */
    
    
    @objc func doubleTapped()
    {
        
        //displayLikes()
        
        //get_like_db = UserDefaults.standard.double(forKey: "likes")
        
        print(get_like_db)
        print(ID);
        //cpy = get_like_db;
        
        //updateLikes()
        //fetchDoubleLikes()
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        //refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        fetchLikes()
        
        //SaveSolution()
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "disconnectPaxiSockets"), object: nil)
        
       
        
        //langName = UserDefaults.standard.string(forKey: "language")!
        //print(ID);
        //print(get_like_db)
        //print(get_like_db);
        //print(langName)
    }
    
    //MARK:- Swipe for save
    @objc func swipedForSave(_ notification: Notification) {
        print("Printing on Swiped")
        
        save_btn_label.setImage(UIImage(named: "saveFilled"), for: .normal)
    }
    @objc func TrippleTapped()
    {
        //SaveSolution()
    }
    
    @objc func SwipedForUpdate(_ notification: Notification)
    {
        print("Update Solution called")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        s_view_display.layer.cornerRadius = 10;
        //s_view_display.layer.borderWidth = 1;
        s_view_display.clipsToBounds = true;
        
        //content_view_s.layer.cornerRadius = 10
        //content_view_s.layer.borderWidth = 1
        //content_view_s.clipsToBounds = true
        //content_view_s.widthAnchor.constraint(equalTo: 10, multiplier: 1000)
        //content_view_s.backgroundColor = .cyan
        //content_view_s.heightAnchor.constraint(equalToConstant: 100)
        
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.3
        
        
        ID = UserDefaults.standard.string(forKey: "id")!;
        langName = UserDefaults.standard.string(forKey: "language")!
        //get_like_db = UserDefaults.standard.double(forKey: "likes")
    
        //NotificationCenter.default.addObserver(self, selector: #selector(swipedForSave(_:)), name: Notification.Name(rawValue: "swipedForSave"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SwipedForUpdate(_:)), name: Notification.Name(rawValue: "SwipedForUpdate"), object: nil)
        
        email = UserDefaults.standard.string(forKey: "email")!
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2;
        contentView.addGestureRecognizer(tap)
        
        
        //let gr = UILongPressGestureRecognizer(target: self, action: #selector(longpress(gestureRecognizer:)))
        
        //gr.minimumPressDuration = 2
        //contentView.addGestureRecognizer(gr)
        
        
        //let tripple_tap = UITapGestureRecognizer(target: self, action: #selector(TrippleTapped))
        //tripple_tap.numberOfTapsRequired = 3;
        //contentView.addGestureRecognizer(tripple_tap)
        
        
        //longpress gesture
        /*
        let gr = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.longpress(gestureRecognizer:)))
        
        gr.minimumPressDuration = 2
        map.addGestureRecognizer(gr)
        */
    }
    /*
    @objc func longpress(gestureRecognizer: UIGestureRecognizer)
    {
        //let u_sername = UserDefaults.standard.string(forKey: "username") ?? "Guest"
        //let userID = UserDefaults.standard.string(forKey: "userId") ?? "11111" //
        //let solusername = UserDefaults.standard.string(forKey: "s_u_sername") ?? "NO one"
        //let puid = UserDefaults.standard.string(forKey: "puid") ?? "No u Id" //User
        //let p_pro = UserDefaults.standard.string(forKey: "p_pro") ?? "no profession"
        //let Uprofession = UserDefaults.standard.string(forKey: "profession") ?? "No u Profession"
        let SID_ = UserDefaults.standard.string(forKey: "sid")
        
        if (gestureRecognizer.state == .began)
        {
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID_!).getDocument { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    print("SID \(SID_!)")
                    let sol = snapshot!.get("SolutionA") as? String ?? "no sol found"
                    UIPasteboard.general.string = sol
                }
                else
                {
                    print("Error occured")
                }
            }
        }
        
        else if(gestureRecognizer.state == .ended)
        {
            print("Started")
        }
       
        
        
    }
    //New way part 5
    //New way part 5
    //New way part 5
    //New database
    */
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Save
    func SaveSolution()
    {
        let u_sername = UserDefaults.standard.string(forKey: "username") ?? "Guest"
        let userID = UserDefaults.standard.string(forKey: "userId") ?? "11111"
        if(save_btn_flag == 0)
        {
            print("Save \(SID)")
            save_btn_label.setImage(UIImage(named: "saveFilled")?.withTintColor(.blue), for: .normal)
            save_btn_flag = 1
            db.collection(email).document(u_sername + " ID: " + userID).collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).updateData(["SaveFlag":true])
            
            //General
            db.collection(email).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + SID).collection("Save").document(u_sername + " ID: " + userID).setData(["SaveFlag":true])
        }
        else
        {
            print("Save \(SID)")
            save_btn_label.setImage(UIImage(named: "save"), for: .normal)
            save_btn_flag = 0
            db.collection(email).document(u_sername + " ID: " + userID).collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).updateData(["SaveFlag":false])
            
            // General
            db.collection(email).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + SID).collection("Save").document(u_sername + " ID: " + userID).setData(["SaveFlag":false])
        }
    }
    
    //MARK:- Likes
    func fetchLikes()
    {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        timeFormatter.dateFormat = "HH:mm:ss"
        let Date = dateFormatter.string(from: date)
        let Time = timeFormatter.string(from: date)
        let dateTime = Date + " " + Time
        
        //let status = UserDefaults.standard.bool(forKey: "status")
        
        //let username = UserDefaults.standard.string(forKey: "username")

        //let userID = UserDefaults.standard.string(forKey: "userId")
        let u_sername = UserDefaults.standard.string(forKey: "username") ?? "Guest"
        let userID = UserDefaults.standard.string(forKey: "userId") ?? "11111" //
        let solusername = UserDefaults.standard.string(forKey: "s_u_sername") ?? "NO one"
        let puid = UserDefaults.standard.string(forKey: "puid") ?? "No u Id" //User
        let p_pro = UserDefaults.standard.string(forKey: "p_pro") ?? "no profession"
        let Uprofession = UserDefaults.standard.string(forKey: "profession") ?? "No u Profession"
        
        //fetching for total likes for leaderboard
        
        // updating likes for users
        
        
        
        
        
        
        
        
        if(like_flag == 0)// false
        {
            SID = UserDefaults.standard.string(forKey: "sid")!
            print(SID)
            //let reason3 = "You liked this solution"
            like_btn_Llabel.setImage(UIImage(named: "heart_fill")?.withTintColor(.red),  for: .normal )
            //updataLikes()
            //print(ID)
            //last time try
            
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).getDocument { (snapshot, error) in
                var uplikes = snapshot!.get("Likes") as? Int ?? 0
                uplikes = uplikes + 1
                self.db.collection(self.email).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + self.SID).updateData(["Likes":uplikes, "Status":true])
                
            }
            
            like_flag = 1
            get_like_db = get_like_db + 1
            likes_label.text = String(get_like_db)
            
           
            //ID = UserDefaults.standard.string(forKey: "sid")!
            
            
            //db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).updateData(["Likes":get_like_db, "Status":true])
            
            db.collection(email).document(u_sername + " ID: " + userID).collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).updateData(["Likes":get_like_db, "Status":true])
            
            //Likes for a current user
            db.collection(email).document(u_sername + " ID: " + userID).collection("Likes").document(solusername + " ID :" + SID).setData(["Type":"Likes", "LikedDate":dateTime, "LikedBy":u_sername, "LikedByID":userID, "Likes":get_like_db, "Profession":p_pro])
            
            
            //likes for general
            
            db.collection(email).document(solusername + " ID: " + puid).collection("Nlikes").document(u_sername + " ID: " + SID).setData(["Type":"NLikes", "LikedDate":dateTime, "LikedBy":u_sername, "LikedByID":userID, "Likes":1, "LikedByProfession":Uprofession])
            
            
            
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).collection("Likes").document(u_sername + " ID: " + userID).setData(["Type":"Likes", "Username":u_sername, "UserID":userID, "Status":true, "Date": dateTime])
            
            
            
            
           
            
            
            // Setting total likes
            
            db.collection(email).document(u_sername + " ID: " + userID).collection("Nlikes").whereField("Type", isEqualTo: "NLikes").getDocuments { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    var sum = 0
                    for documents in snapshot!.documents
                    {
                        let data = documents.data()
                        let likes = data["Likes"] as? Int ?? 0
                        let ulname = data["LikedBy"] as? String ?? "no name found"
                        if(ulname == u_sername)
                        {
                            print("skip")
                        }
                        else
                        {
                            sum = sum + likes
                        }
                        print(sum)
                        print("Sum not working")
                    }
                    let sumLikes = sum
                    print("TOtal Likes: \(sumLikes)")
                   
                    let newdata = NTotalLikes(Likes:sumLikes)
                    self.structNTotalLikes.append(newdata)
                    
                    if(u_sername == "Guest")
                    {
                        
                    }
                    else
                    {
                        self.db.collection(self.email).document("Leaderboard").collection("TotalLikes").document(u_sername + " ID: " + userID).setData(["Type":"TotalLikes", "Likes":sum,"Name":u_sername, "Profession":Uprofession])
                    }
                    
                }
                else
                {
                    print("Error")
                }
            }
            
            
            
            
            
            
            
            
            
            
           
            
            
            /*
            //Updating likes for user history
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).getDocument { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    let uname = snapshot?.get("Username") as? String ?? "No username"
                    let reason = snapshot?.get("Reason") as? String ?? "No reason given"
                    print("Uname: \(uname)")
                    
                    if(uname == username!)
                    {
                        self.db.collection(self.email).document(username! + " ID: " + userID!).collection("USolution").document("Solution ID: " + self.SID).updateData(["Likes":self.get_like_db, "Status":true, "Reason":reason3])
                    }
                    else
                    {
                        
                    }
                    
                   
                }
                else
                {
                    print("Not going inside")
                }
            }
            */
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "disconnectPaxiSockets"), object: nil)
            
            
            
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
            //let reason4 = "You dislied this solution"
            like_btn_Llabel.setImage(UIImage(named: "heart_outline"), for: .normal )
            //updataLikes()
            print(ID)
            
            like_flag = 0
            get_like_db = get_like_db - 1
            
            likes_label.text = String(get_like_db)
            
            //ID = UserDefaults.standard.string(forKey: "sid")!
            SID = UserDefaults.standard.string(forKey: "sid")!
            print(SID)
            
            //last time try
            
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).getDocument { (snapshot, error) in
                var uplikes = snapshot!.get("Likes") as? Int ?? 0
                uplikes = uplikes - 1
                self.db.collection(self.email).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + self.SID).updateData(["Likes":uplikes, "Status":false])
                
            }
            
            
            
            //db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).updateData(["Likes":get_like_db, "Status":false])
            
            db.collection(email).document(u_sername + " ID: " + userID).collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).updateData(["Likes":get_like_db, "Status":false])
            
            db.collection(email).document(u_sername + " ID: " + userID).collection("Likes").document(solusername + " ID :" + SID).updateData(["Likes":get_like_db])
            
            db.collection(email).document(solusername + " ID: " + puid).collection("Nlikes").document(u_sername + " ID: " + SID).updateData(["Likes":0])
            
            
            //new way to fetch likes for user screen
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).collection("Likes").document(u_sername + " ID: " + userID).updateData(["Status":false])
            
            
            //updating leaderboard
            db.collection(email).document(u_sername + " ID: " + userID).collection("Nlikes").whereField("Type", isEqualTo: "NLikes").getDocuments { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    var sum = 0
                    for documents in snapshot!.documents
                    {
                        let data = documents.data()
                        let likes = data["Likes"] as? Int ?? 0
                        let ulname = data["LikedBy"] as? String ?? "no name found"
                        if(ulname == u_sername)
                        {
                            print("skip")
                        }
                        else
                        {
                            sum = sum + likes
                        }
                        print(sum)
                        print("Sum not working")
                    }
                    let sumLikes = sum
                    print("TOtal Likes: \(sumLikes)")
                   
                    let newdata = NTotalLikes(Likes:sumLikes)
                    self.structNTotalLikes.append(newdata)
                    
                    if(u_sername == "Guest")
                    {
                        
                    }
                    else
                    {
                        self.db.collection(self.email).document("Leaderboard").collection("TotalLikes").document(u_sername + " ID: " + userID).setData(["Type":"TotalLikes", "Likes":sum,"Name":u_sername, "Profession":Uprofession])
                    }
                }
                else
                {
                    print("Error")
                }
            }
            
            
            
            
            
            
            
            
            
            
            //db.collection(email!).document("Leaderboard").collection("TotalLikes").document(u_sername + " ID: " + userID).setData(["Type":"TotalLikes", "Likes":sum,"Name":u_sername, "Profession":Uprofession])
            /*
            db.collection(email).document(u_sername + " ID: " + userID).collection("NLikes").whereField("Type", isEqualTo: "NLikes").getDocuments { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    var sum = 0
                    for documents in snapshot!.documents
                    {
                        let data = documents.data()
                        let likes = data["Likes"] as? Int ?? 0
                        sum = sum + likes
                    }
                    let sumLikes = sum
                    self.xyzlikes = sum
                    let newdata = ForTotalLikes(Likes:sumLikes)
                    self.structForTotalLikes.append(newdata)
                    
                    self.db.collection(self.email).document("Leaderboard").collection("TotalLikes").document(u_sername + " ID: " + userID).updateData(["Likes":])
                }
                else
                {
                    print("Error")
                }
            }
            */
            
            
            
            
            
            
            
            
            //db.collection(email).document("Leaderboard").collection("TotalLikes").document(u_sername + " ID: " + userID).updateData(["Likes":xyzlikes])
            
            /*
            //Updating likes for user history
            db.collection(email).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + SID).getDocument { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    let uname = snapshot?.get("Username") as? String ?? "No username"
                    print("Uname: \(uname)")
                    
                    if(uname == username!)
                    {
                        self.db.collection(self.email).document(username! + " ID: " + userID!).collection("USolution").document("Solution ID: " + self.SID).updateData(["Likes":self.get_like_db, "Status":true, "Reason":reason4])
                    }
                   
                }
                else
                {
                    print("Not going inside")
                }
            }
            */
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "disconnectPaxiSockets"), object: nil)
            
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

}
