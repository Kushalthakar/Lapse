//
//  HistoryViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 09/07/21.
//

import UIKit
import Firebase

//MARK:- Struct
struct HistoryUserData
{
    var Id, Error, Solution, PostedOn, Activity : String
    var Likes : Int
}
//MARK:- HistoryViewController
class HistoryViewController: UIViewController, UISearchBarDelegate {
    
    var History = [HistoryUserData]()
    var filterHistory = [HistoryUserData]()
    var db = Firestore.firestore()
    var searchBarText = ""
    
    @IBOutlet weak var table_view: UITableView!
    
    //var searchController = UISearchController(searchResultsController: nil)
    
   
    //MARK: - Search
    
    @IBOutlet weak var search_history: UISearchBar!
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = ""
        viewDidLoad()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        search_history.searchTextField.text = searchBarText
    }
    func searchBar(_ search_history: UISearchBar, textDidChange searchText: String) {
        let newsearchtext = searchText.lowercased().components(separatedBy: .whitespacesAndNewlines).joined()
        filterHistory = []
        print(newsearchtext)
        
        if(searchText == "")
        {
            filterHistory = History
            table_view.reloadData()
        }
        else
        {
            for filterData in History
            {
                if(filterData.Error.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterHistory.append(filterData)
                }
                else if (filterData.Solution.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterHistory.append(filterData)
                }
                else if (filterData.PostedOn.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterHistory.append(filterData)
                }
            
            }
            
            table_view.reloadData()
            search_history.searchTextField.text = searchText
        }
        searchBarText = searchText
        
    }
    
    
    //MARK:- Sort
    @IBAction func sort_h_btn(_ sender: Any)
    {
        print("Sort button clicked")
        print("Working")
        
        let email = UserDefaults.standard.string(forKey: "email")
        let username = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        
        let alert = UIAlertController(title: "Sort", message: "Select sort style", preferredStyle: .alert)
        
       
        alert.addAction(UIAlertAction(title: "Newest", style: .default, handler: {action in
            self.db.collection(email!).document(username! + " ID: " + userID!).updateData(["HistorySortFlag":true])
            
            self.viewDidLoad()
        }))
        alert.addAction(UIAlertAction(title: "Oldest", style: .default, handler: {action in
            self.db.collection(email!).document(username! + " ID: " + userID!).updateData(["HistorySortFlag":false])
            
            self.viewDidLoad()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.hidesBackButton = true
        
        //navigationItem.searchController = searchController
        //searchController.searchBar.delegate = self
       
        History = []
        filterHistory = History
        table_view.delegate = self
        table_view.dataSource = self
        search_history.delegate = self
        
        
        
        let email = UserDefaults.standard.string(forKey: "email");
        
        let username = UserDefaults.standard.string(forKey: "username")
        
        //let profession = UserDefaults.standard.string(forKey: "profession")
        
        let userID = UserDefaults.standard.string(forKey: "userId")
        
        db.collection(email!).document(username! + " ID: " + userID!).collection("USolution").whereField("Type", isEqualTo: "Solution").getDocuments { (snapshot, error) in
            if(error == nil && snapshot != nil)
            {
                for documents in snapshot!.documents
                {
                    let data = documents.data()
                    let id = data["ID"] as? String ?? "no id"
                    let error = data["USError"] as? String ?? "No error"
                    let solution = data["SolutionA"] as? String ?? "No solution found"
                    let dateTime = data["DateTime"] as? String ?? "No date specified"
                    let likes = data["Likes"] as? Int ?? 0
                    let activity = data["Reason"] as? String ?? "No reason"
                    let newData = HistoryUserData(Id:id ,Error: error, Solution: solution, PostedOn: dateTime,Activity: activity, Likes: likes)
                    self.History.append(newData)
                   
                }
                
                self.db.collection(email!).document(username! + " ID: " + userID!).getDocument { (snapshot, error) in
                    if(error == nil && snapshot != nil)
                    {
                        //let sort = snapshot!.get("Sort") as? Int ?? 1
                        let time = snapshot?.get("HistorySortFlag") as? Bool ?? false
                        
                       
                        
                        if(time == false)
                        {
                            self.History.sort {$0.PostedOn < $1.PostedOn}
                            self.table_view.reloadData()
                        }
                        else
                        {
                            self.History.sort {$0.PostedOn > $1.PostedOn}
                            self.table_view.reloadData()
                        }
                       
                    }
                    
                }
                print("History: \(self.History)")
                print("History Count: \(self.History.count)")
                self.table_view.reloadData()
                
            }
        }
        
        
        
        
        
        
        
        
        
        DispatchQueue.main.async {
            self.table_view.reloadData()
        }
        table_view.reloadData()
        
        
        
        
        
        
        
        
        
        
        
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK:- TableView
extension HistoryViewController: UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!filterHistory.isEmpty)
        {
            return filterHistory.count
        }
        else
        {
            return History.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        
        
        if(!filterHistory.isEmpty)
        {
            let data = filterHistory[indexPath.row]
            
            cell.error_history_label.text = "Error: \(data.Error)"
            cell.history_data_label.text = "Solution: \(data.Solution)"
            cell.posted_on.text = "Posted on: \(data.PostedOn)"
            cell.u_likes.text = "Likes: \(data.Likes)"
            cell.activity_label.text = "Activity: \(data.Activity)"
            
        }
        else
        {
            let data = History[indexPath.row]
            
            cell.error_history_label.text = "Error: \(data.Error)"
            cell.history_data_label.text = "Solution: \(data.Solution)"
            cell.posted_on.text = "Posted on: \(data.PostedOn)"
            cell.u_likes.text = "Likes: \(data.Likes)"
            cell.activity_label.text = "Activity: \(data.Activity)"
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected: \(indexPath.row)")
        
       
        
        
    }
    /*
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        /*
        let date = Date()
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        timeFormatter.dateFormat = "HH:mm:ss"
        let Date = dateFormatter.string(from: date)
        let Time = timeFormatter.string(from: date)
        let dateTime = Date + " " + Time
        */
        //let email = UserDefaults.standard.string(forKey: "email")
        //let u_sername = UserDefaults.standard.string(forKey: "username")
        //let userID = UserDefaults.standard.string(forKey: "userId")
        //let ID = UserDefaults.standard.string(forKey: "id")!;
        //let langName = UserDefaults.standard.string(forKey: "language")!
        
        let update = UIContextualAction(style: .normal, title: "Update") { (action, view, completionHandler) in
            print("History Update working fine")
            let data = self.History[indexPath.row]
            UserDefaults.standard.setValue(data.Id, forKey: "HistorySolutionId")
            UserDefaults.standard.setValue(data.Solution, forKey: "HistorySolution")
            self.performSegue(withIdentifier: "HistoryToPopSeg", sender: self)
           
            //self.popup_update.isHidden = false
            //NotificationCenter.default.post(name: Notification.Name(rawValue: "SwipedForUpdate"), object: nil)
            completionHandler(true)
        }
        
        update.backgroundColor = .systemGreen
        update.image = UIImage(named: "update")?.withTintColor(.white)
        let swipe = UISwipeActionsConfiguration(actions: [update])
        return swipe
    }
    */
    
    
    
    
}
