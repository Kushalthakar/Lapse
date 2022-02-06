//
//  NotificationViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 14/07/21.
//

import UIKit
import Firebase

//MARK:- Struct
struct Notification_
{
    var Username, Time : String
}

//MARK:- NotificationViewController
class NotificationViewController: UIViewController
{
    
    @IBOutlet weak var table_view: UITableView!
    var db = Firestore.firestore()
    
    var structNotification = [Notification_]()
    
    let refreshControl = UIRefreshControl()
    
    //MARK:- Reload page
    @objc func ReloadPage(_ notification:Notification)
    {
        //structNotification = []
        print("Reloading Notifications")
        //table_view.reloadData()
        viewDidLoad()
    }
    //MARK:- Refresh Page
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        viewDidLoad()
        refreshControl.endRefreshing()
    }
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Notifications"
        structNotification = []
        table_view.dataSource = self
        table_view.delegate = self
        tabBarController?.delegate = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        table_view.addSubview(refreshControl)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ReloadPage(_:)), name: Notification.Name(rawValue: "ReloadPage"), object: nil)
        
        let email = UserDefaults.standard.string(forKey: "email")
        let u_sername = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        //let ID = UserDefaults.standard.string(forKey: "id")!;
        //let langName = UserDefaults.standard.string(forKey: "language")!
        
        
        db.collection(email!).document(u_sername! + " ID: " + userID!).collection("Nlikes").whereField("Type", isEqualTo: "NLikes").getDocuments { (snapshot, error) in
            if(error == nil && snapshot != nil)
            {
                for documents in snapshot!.documents
                {
                    let data = documents.data()
                    let username = data["LikedBy"] as? String ?? "No name found"
                    let time = data["LikedDate"] as? String ?? "NO time"
                    let newdata = Notification_(Username: username, Time:time)
                    if (newdata.Username == u_sername)
                    {
                        
                    }
                    else
                    {
                        self.structNotification.append(newdata)
                    }
                   
                   
                }
                //sorting
                self.structNotification.sort { $0.Time > $1.Time}
                self.table_view.reloadData()
            }
            else
            {
                print("Error occured")
            }
            print("Notification count: \(self.structNotification.count)")
        }
        
        DispatchQueue.main.async {
            self.table_view.reloadData()
        }
        table_view.reloadData()

        
    }
    

    

}
//MARK:- TableView
extension NotificationViewController: UITableViewDelegate,UITableViewDataSource
{
    //func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //    return 50
    //}
    
    //func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return 50
   // }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return structNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationTableViewCell
        
        let data = structNotification[indexPath.row]
        
        cell.notification_label.text = "\(data.Username) Liked your solution at \(data.Time)"
        //cell.separatorInset = UIEdgeInsets(top: 20,left: 0,bottom: 20,right: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.row)")
    }
}

//MARK:- Tabbar
extension NotificationViewController: UITabBarDelegate, UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if(tabBarIndex == 0)
        {
            print("Notification Home called")
            //table_view.reloadData()
            //view.reloadInputViews()
            table_view.reloadData()
            viewDidLoad()
            //table_view.reloadData()
        }
        if(tabBarIndex == 1)
        {
            print("Notification_notification called")
            //table_view.reloadData()
            table_view.reloadData()
            viewDidLoad()
            //NotificationCenter.default.post(name: Notification.Name(rawValue: "ReloadPage"), object: nil)
        }
        if(tabBarIndex == 2)
        {
            print("Notification Profile called")
            table_view.reloadData()
            viewDidLoad()
        }
    }
    
    
}
