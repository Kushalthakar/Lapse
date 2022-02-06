//
//  LeaderboardViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 12/07/21.
//

import UIKit
import Firebase
//MARK:- Struct
struct Leaderboard {
    var Username, Profession : String
    var Likes: Int
}
struct LTotalLikes {
    var likes:Int
}
//MARK:- LeaderboardViewController
class LeaderboardViewController: UIViewController {
    
    var db = Firestore.firestore()
    
    var structLeaderboard = [Leaderboard]()
    
    var Llikes = [LTotalLikes]()
    
    @IBOutlet weak var view_design: UIView!
    @IBOutlet weak var stack_view_design: UIStackView!
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var table_view: UITableView!
    
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        viewDidLoad()
        refreshControl.endRefreshing()
    }
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        table_view.addSubview(refreshControl)
        
        navigationItem.hidesBackButton = true
        
        stack_view_design.layer.cornerRadius = 10
        stack_view_design.clipsToBounds = true
        
        view_design.layer.cornerRadius = 10
        view_design.layer.shadowOffset = CGSize(width: 5, height: 5)
        view_design.layer.shadowRadius = 10
        view_design.layer.shadowOpacity = 0.3
        
        
        
        table_view.delegate = self
        table_view.dataSource = self
        
        
        DispatchQueue.main.async {
            self.table_view.reloadData()
        }
        table_view.reloadData()
        
        let u_sername = UserDefaults.standard.string(forKey: "username") ?? "Guest"
        let userID = UserDefaults.standard.string(forKey: "userId") ?? "11111"
        //let solusername = UserDefaults.standard.string(forKey: "s_u_sername") ?? "NO one"
        //let puid = UserDefaults.standard.string(forKey: "puid") ?? "No u Id"
        //let p_pro = UserDefaults.standard.string(forKey: "p_pro") ?? "no profession"
        let email = UserDefaults.standard.string(forKey: "email")
        let Uprofession = UserDefaults.standard.string(forKey: "profession") ?? "No u Profession"
        
        
        //updating
        print("Leaderboard")
        db.collection(email!).document(u_sername + " ID: " + userID).collection("Nlikes").whereField("Type", isEqualTo: "NLikes").getDocuments { (snapshot, error) in
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
               
                let newdata = LTotalLikes(likes:sumLikes)
                self.Llikes.append(newdata)
                
                if(u_sername == "Guest")
                {
                   
                }
                else
                {
                    self.db.collection(email!).document("Leaderboard").collection("TotalLikes").document(u_sername + " ID: " + userID).setData(["Type":"TotalLikes", "Likes":sum,"Name":u_sername, "Profession":Uprofession])
                }
                
            }
            else
            {
                print("Error")
            }
        }
        
        
        
        
        
        //fetching
        db.collection(email!).document("Leaderboard").collection("TotalLikes").whereField("Type", isEqualTo: "TotalLikes").getDocuments { (snapshot, error) in
            if(error == nil && snapshot != nil)
            {
                for documents in snapshot!.documents
                {
                    let data = documents.data()
                    let likes = data["Likes"] as? Int ?? 0
                    let name = data["Name"] as? String ?? "no name"
                    let profession = data["Profession"] as? String ?? "no professtion"
                    let newdata = Leaderboard(Username: name, Profession: profession, Likes: likes)
                    self.structLeaderboard.append(newdata)
                }
                
                self.structLeaderboard.sort { $0.Likes > $1.Likes}
                self.table_view.reloadData()
            }
            
        }
        table_view.reloadData()
        print("going in leaderboard")
    }
    
    
    
   

}
//MARK: TableView
extension LeaderboardViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return structLeaderboard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaderboardTableViewCell
        
        let data = structLeaderboard[indexPath.row]
        let newIndexpath = indexPath.row
        cell.rank_label.text = String(newIndexpath + 1)
        cell.name_label.text = data.Username
        cell.position_label.text = data.Profession
        cell.likes_label.text = String(data.Likes)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.row)")
    }
    
    
}
