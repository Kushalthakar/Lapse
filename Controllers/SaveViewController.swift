//
//  SaveViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 09/07/21.
//

import UIKit
import Firebase

//MARK:- Struct
struct Save {
    var ID, PostedBy, PostedOn, Error, Solution, SavedOn, LangName,LangId: String
    var SaveFlag:Bool
}

//MARK:-SaveViewController
class SaveViewController: UIViewController,UISearchBarDelegate {

    var db = Firestore.firestore()
    
    var save = [Save]()
    
    var filterSave = [Save]()
    
    var searchBarText = ""
    
    var height : CGFloat = 40
    
    @IBOutlet weak var table_view: UITableView!
    
    @IBOutlet weak var search_save: UISearchBar!
    //MARK: - Search
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search_save.searchTextField.text = ""
        viewDidLoad()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        search_save.searchTextField.text = searchBarText
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let newsearchtext = searchText.lowercased().components(separatedBy: .whitespacesAndNewlines).joined()
        filterSave = []
        print(newsearchtext)
        
        if(searchText == "")
        {
            filterSave = save
            table_view.reloadData()
        }
        else
        {
            for filterData in save
            {
                if (filterData.Error.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterSave.append(filterData)
                }
                else if (filterData .Solution.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterSave.append(filterData)
                }
                else if(filterData.PostedBy.components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterSave.append(filterData)
                }
                else if(filterData.SavedOn.components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterSave.append(filterData)
                }
                
            }
            
            table_view.reloadData()
            
        }
        
        searchBarText = searchText
    }
    
    
    
    
    //MARK: Sort
    @IBAction func sort_s(_ sender: Any)
    {
        print("Save sort working")
        let email = UserDefaults.standard.string(forKey: "email")
        let username = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        
        let alert = UIAlertController(title: "Sort", message: "Select sort style", preferredStyle: .alert)
        
       
        alert.addAction(UIAlertAction(title: "Newest", style: .default, handler: {action in
            self.db.collection(email!).document(username! + " ID: " + userID!).updateData(["SaveSortFlag":true])
            
            self.viewDidLoad()
        }))
        alert.addAction(UIAlertAction(title: "Oldest", style: .default, handler: {action in
            self.db.collection(email!).document(username! + " ID: " + userID!).updateData(["SaveSortFlag":false])
            
            self.viewDidLoad()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - On DoubleTap
    @objc func DoubleTapped()
    {
        let saveFID = UserDefaults.standard.string(forKey: "savefid") ?? "1111"
        print("Double Tapped on SaveViewController")
        print(saveFID)
        //let indexpath = UserDefaults.standard.string(forKey: "saveindexpath")
        let email = UserDefaults.standard.string(forKey: "email")
        let u_sername = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        print("D Tapped")
        
        
        let alert = UIAlertController(title: "Un-save", message: "Do you want to un-save?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            self.db.collection(email!).document(u_sername! + " ID: " + userID!).collection("Save").document("SaveID: " + saveFID).delete()
            self.viewDidLoad()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        save = []
        filterSave = save
        table_view.delegate = self
        table_view.dataSource = self
        search_save.delegate = self
        
        navigationItem.hidesBackButton = true
        
        let email = UserDefaults.standard.string(forKey: "email")
        let u_sername = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        
        db.collection(email!).document(u_sername! + " ID: " + userID!).collection("Save").getDocuments { (snapshot, error) in
            if(error == nil && snapshot != nil)
            {
                for documents in snapshot!.documents
                {
                    let data = documents.data()
                    let id = data["SaveID"] as? String ?? "Not available"
                    let postedby = data["SUSUsername"] as? String ?? "Not available"
                    let postedon = data["Date"] as? String ?? "Not available"
                    let savedon = data["SUSDate"] as? String ?? "Not available"
                    let error_ = data["SUError"] as? String ?? "Not available"
                    let solution = data["SUSolution"] as? String ?? "Not available"
                    let saveflag = data["SaveFlag"] as? Bool ?? false
                    let langname = data["LangName"] as? String ?? "Not available"
                    let langid = data["LangId"]as? String ?? "Not available"
                    let newData = Save(ID:id ,PostedBy: postedby, PostedOn: postedon, Error: error_, Solution: solution, SavedOn: savedon, LangName: langname, LangId: langid, SaveFlag: saveflag)
                    self.save.append(newData)
                }
                
                self.db.collection(email!).document(u_sername! + " ID: " + userID!).getDocument { (snapshot, error) in
                    if(error == nil && snapshot != nil)
                    {
                        //let sort = snapshot!.get("Sort") as? Int ?? 1
                        let time = snapshot?.get("SaveSortFlag") as? Bool ?? false
                        
                       
                        
                        if(time == false)
                        {
                            self.save.sort {$0.SavedOn < $1.SavedOn}
                            self.table_view.reloadData()
                        }
                        else
                        {
                            self.save.sort {$0.SavedOn > $1.SavedOn}
                            self.table_view.reloadData()
                        }
                       
                    }
                    
                }
                
                
                self.table_view.reloadData()
            }
            
            
            else
            {
                print("No Data found")
            }
            print("Save Count: \(self.save.count)")
        }
        
        
        DispatchQueue.main.async {
            self.table_view.reloadData()
        }
        table_view.reloadData()
        
        print("going in save")
        //NotificationCenter.default.addObserver(self, selector: #selector(DoubleTapped), name: Notification.Name(rawValue: "DoubleTapped"), object: nil)
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


extension SaveViewController: UITableViewDelegate, UITableViewDataSource
{

    
    //MARK:- Number Of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!filterSave.isEmpty)
        {
            return filterSave.count
        }
        else
        {
            return save.count
        }
        
    }
    
    //MARK:- Cell For Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SaveTableViewCell
        
        if(!filterSave.isEmpty)
        {
            let data = filterSave[indexPath.row]
            
            cell.save_error_label.text = "Error: \(data.Error)"
            cell.save_solution_label.text = "Solution: \(data.Solution)"
            cell.posted_by.text = "Posted by: \(data.PostedBy)"
            cell.posted_on.text = "Posted on: \(data.PostedOn)"
            cell.saved_on.text = "Saved on: \(data.SavedOn)"
            
            self.table_view.rowHeight = UITableView.automaticDimension
            self.table_view.estimatedRowHeight = 300
        }
        else
        {
            let data = save[indexPath.row]
            
            cell.save_error_label.text = "Error: \(data.Error)"
            cell.save_solution_label.text = "Solution: \(data.Solution)"
            cell.posted_by.text = "Posted by: \(data.PostedBy)"
            cell.posted_on.text = "Posted on: \(data.PostedOn)"
            cell.saved_on.text = "Saved on: \(data.SavedOn)"
            
            self.table_view.rowHeight = UITableView.automaticDimension
            self.table_view.estimatedRowHeight = 300
        }
        
        
        return cell
    }
    
    //MARK:- Did Select Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.row)")
        
        if(!filterSave.isEmpty)
        {
            let data = filterSave[indexPath.row]
            UserDefaults.standard.setValue(data.ID, forKey: "savefid")
        }
        else
        {
            let data = save[indexPath.row]
            UserDefaults.standard.setValue(data.ID, forKey: "savefid")
        }
        
        
        //UserDefaults.standard.setValue(indexPath.row, forKey: "saveindexpath")
        
    }
    
    //MARK:-On Swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SaveTableViewCell
        
        
        
        
        let email = UserDefaults.standard.string(forKey: "email")
        let u_sername = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        
       
        //let ID = UserDefaults.standard.string(forKey: "id")!;
        //let langName = UserDefaults.standard.string(forKey: "language")!
        
        /*
        //Fetching save status for likes
        
        db.collection(email!).document(u_sername!  + " ID: " + userID!).collection("Save").whereField("Type", isEqualTo: "Saved").getDocuments { (snapshot, error) in
            if(error == nil && snapshot != nil)
            {
                for documments in snapshot!.documents
                {
                    let data = documments.data()
                    let saveflag = data["SaveFlag"] as? Bool ?? false
                    let newdata = StructSave(SaveStatus: saveflag)
                    self.saveStruct.append(newdata)
                }
                
            }
            else
            {
                print("No record found")
            }
        }
        */
         
        //let saveData = self.saveStruct[indexPath.row]
        
        let save = UIContextualAction(style: .normal, title: "Un-Save", handler: {
            (action,view,completionHandler) in
        
            view.frame.inset(by: UIEdgeInsets(top: 50, left: 10, bottom: 50, right: 10))
            
            
            //let saveData = self.saveStruct[indexPath.row]
                
            
            
            if(!self.filterSave.isEmpty)
            {
                let data = self.filterSave[indexPath.row]
                //let ID = UserDefaults.standard.string(forKey: "id")!;
                //let langName = UserDefaults.standard.string(forKey: "language")!
                
                let alert  = UIAlertController(title: "un-Save", message: "Do you want to un-save?", preferredStyle: .alert)
                        
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                    //cell.save_btn_label.setImage(UIImage(named: "bookmark.fill"), for: .normal)
                    print("Solution swipe working \(indexPath.row)")
                            
                    self.db.collection(email!).document(u_sername! + " ID: " + userID!).collection("Save").document("SaveID: " + data.ID).delete { (erroe) in
                        if(erroe == nil)
                        {
                            print("Deleted")
                        }
                        else
                        {
                            print("Delete not working")
                        }
                    }
                    
                   
                    
                    
                    //lang>solution>save>kushal
                    self.db.collection(email!).document(data.LangName + " ID: " + data.LangId).collection("Solution").document("Solution ID: " + data.ID).collection("Save").document(u_sername! + " ID: " + userID!).delete()
                    
                    
                    
                    // user>email
                    self.db.collection(email!).document(u_sername! + " ID: " + userID!).collection(email!).document(data.LangName + " ID: " + data.LangId).collection("Solution").document("Solution ID: " + data.ID).updateData(["SaveFlag":false])
                    
                    
                    //NotificationCenter.default.post(name: Notification.Name(rawValue: "swipedForSave"), object: nil)
                    
                    
                           
                    self.viewDidLoad()
                    self.table_view.reloadData()
                    
                   
                }))
                        
                alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                        
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                let data = self.save[indexPath.row]
                //let ID = UserDefaults.standard.string(forKey: "id")!;
                //let langName = UserDefaults.standard.string(forKey: "language")!
                
                let alert  = UIAlertController(title: "un-Save", message: "Do you want to un-save?", preferredStyle: .alert)
                        
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                    //cell.save_btn_label.setImage(UIImage(named: "bookmark.fill"), for: .normal)
                    print("Solution swipe working \(indexPath.row)")
                            
                    self.db.collection(email!).document(u_sername! + " ID: " + userID!).collection("Save").document("SaveID: " + data.ID).delete { (erroe) in
                        if(erroe == nil)
                        {
                            print("Deleted")
                        }
                        else
                        {
                            print("Delete not working")
                        }
                    }
                    
                   
                    
                    
                    //lang>solution>save>kushal
                    self.db.collection(email!).document(data.LangName + " ID: " + data.LangId).collection("Solution").document("Solution ID: " + data.ID).collection("Save").document(u_sername! + " ID: " + userID!).delete()
                    
                    
                    
                    // user>email
                    self.db.collection(email!).document(u_sername! + " ID: " + userID!).collection(email!).document(data.LangName + " ID: " + data.LangId).collection("Solution").document("Solution ID: " + data.ID).updateData(["SaveFlag":false])
                    
                    
                    //NotificationCenter.default.post(name: Notification.Name(rawValue: "swipedForSave"), object: nil)
                    
                    
                           
                    self.viewDidLoad()
                    self.table_view.reloadData()
                    
                   
                }))
                        
                alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                        
                self.present(alert, animated: true, completion: nil)
            }
            
        completionHandler(true)
        })
        
        /*
        if(self.savedOrNot == false)
        {
            save.image = UIImage(systemName: "bookmark")
        }
        else
        {
            save.image = UIImage(systemName: "bookmark.fill")
        }
        */
        
        save.backgroundColor = .systemRed
        //save.title = "Un-save"
        let swipe = UISwipeActionsConfiguration(actions: [save])
        return swipe
    }
    
    
}

//MARK:- Tab Bar
extension SaveViewController: UITabBarDelegate, UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if(tabBarIndex == 0)
        {
            print("Home called")
            //table_view.reloadData()
            //view.reloadInputViews()
            //table_view.reloadData()
            //viewDidLoad()
            //table_view.reloadData()
        }
        if(tabBarIndex == 1)
        {
            print("Notification_notification called")
            //table_view.reloadData()
            //viewDidLoad()
            //NotificationCenter.default.post(name: Notification.Name(rawValue: "ReloadPage"), object: nil)
        }
        if(tabBarIndex == 2)
        {
            print("Profile called")
            viewDidLoad()
        }
    }
    
    
}
