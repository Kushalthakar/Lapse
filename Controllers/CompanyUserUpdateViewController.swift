//
//  CompanyUserUpdateViewController.swift
//  StartUpIdea1
//
//
//  Created by Kushal Thakar on 22/07/21.
//CtoUSeg

import UIKit
import Firebase
//MARK:- Struct
struct UsersStruct
{
    var Users,ID:String
}
//MARK:- CompanyUserUpdateViewController
class CompanyUserUpdateViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var table_view: UITableView!
    
    
    @IBOutlet weak var searchController: UISearchBar!
    
    var db = Firestore.firestore()
    var structuser = [UsersStruct]()
    var filterUser = [UsersStruct]()
    var searchBarText = ""
    let refreshControl = UIRefreshControl()
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchTextField.text = ""
        viewDidLoad()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchController.searchTextField.text = searchBarText
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        filterUser = []
        let newsearchtext = searchText.lowercased().components(separatedBy: .whitespacesAndNewlines).joined()
        
        if(searchText == "")
        {
            filterUser = structuser
            table_view.reloadData()
        }
        else
        {
            for filterData in structuser
            {
                if(filterData.Users.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterUser.append(filterData)
                }
            }
            table_view.reloadData()
        }
        searchBarText = searchText
        table_view.reloadData()
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        viewDidLoad()
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table_view.delegate = self
        table_view.dataSource = self
        searchController.delegate = self
        
        structuser = []
        filterUser = structuser
        
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        table_view.addSubview(refreshControl)
        
        // Do any additional setup after loading the view.
        let email = UserDefaults.standard.string(forKey: "email")
        db.collection(email!).whereField("Aggrement", isEqualTo: true).getDocuments { (snapshot, error) in
            if(error == nil && snapshot != nil)
            {
                for documents in snapshot!.documents
                {
                    let data = documents.data()
                    let id = data["ID"] as? String ?? "No Id"
                    let username = data["Username"] as? String ?? "No name"
                    let newdata = UsersStruct(Users: username, ID: id)
                    self.structuser.append(newdata)
                }
                print(self.structuser)
                self.table_view.reloadData()
            }
            else
            {
                print("Error")
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
extension CompanyUserUpdateViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(!filterUser.isEmpty)
        {
            return filterUser.count
        }
        else
        {
            return structuser.count
        }
        
    }
    //MARK:- Cell data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CompanyUserUpdateTableViewCell
        
        if(!filterUser.isEmpty)
        {
            let data = filterUser[indexPath.row]
            cell.label.text = data.Users
        }
        else
        {
            let data = structuser[indexPath.row]
            cell.label.text = data.Users
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.row)")
    }
    
    //MARK:- On swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let email = UserDefaults.standard.string(forKey: "email")
        //let Husername = UserDefaults.standard.string(forKey: "username") ?? "Guest"
        //let Hprofession = UserDefaults.standard.string(forKey: "profession") ?? "p"
        //let userID = UserDefaults.standard.string(forKey: "userId") ?? "12345"
        
        
        
        
        
        
       
        
        //let data = structuser[indexPath.row]
        let swipe = UIContextualAction(style: .normal, title: "Freez") { (action, view, complition) in
            //print("Swiped \(data.Users)")
            
            if(!self.filterUser.isEmpty)
            {
                let data = self.filterUser[indexPath.row]
                self.db.collection(email!).document("\(data.Users) ID: \(data.ID)").getDocument { (snapshot, error) in
                    if(error == nil && snapshot != nil)
                    {
                        //let id_ = snapshot?.get("ID") as? String ?? "No ID"
                        let user = snapshot!.get("User") as? String ?? "No user"
                        if(user != "Freez" )
                        {
                            let alert = UIAlertController(title: "Freez", message: "Do you wanna freez \(data.Users)'s account", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
                                action in
                                
                                self.db.collection(email!).document(email!).updateData(["\(data.Users) ID":data.ID])
                                
                                self.db.collection(email!).document(data.Users + " ID: " + data.ID).updateData(["ID":"Freez"])
                                self.db.collection(email!).document(data.Users + " ID: " + data.ID).updateData(["User":"Freez"])
                                
                                self.db.collection(email!).document(email!).getDocument { (snapshot, error) in
                                    
                                    var newc = snapshot!.get("UserCount") as? Int ?? 0
                                    newc = newc - 1
                                    self.db.collection(email!).document(email!).updateData(["UserCount":newc])
                                    /*
                                    var u_count = snapshot!.get("UserCount") as? Int ?? 0
                                    self.db.collection(email!).whereField("User", isEqualTo: "Freez").getDocuments { (snapshot, error) in
                                        if(error == nil && snapshot != nil)
                                        {
                                            for _ in snapshot!.documents
                                            {
                                                u_count = u_count - 1
                                            }
                                            self.db.collection(email!).document(email!).updateData(["UserCount":u_count])
                                        }
                                        else
                                        {
                                            print("Error occured")
                                        }
                                    }
                                    */
                                }
                                
                                
                                /*
                                if (Auth.auth().currentUser != nil)
                                {
                                    UserDefaults.standard.setValue("Guest", forKey: "username")
                                    UserDefaults.standard.setValue("p", forKey: "profession")
                                    UserDefaults.standard.setValue("12345", forKey: "userId")
                                    
                                    do
                                    {
                                        try Auth.auth().signOut()
                                        //self.tabBarController?.viewWillDisappear(true)
                                        UserDefaults.standard.setValue("", forKey: "email")
                                        //performSegue(withIdentifier: "PtoLSeg", sender: self)
                                        
                                        
                                        
                                        //let ss = storyboard?.instantiateViewController(identifier: "loginVC")
                                        //storyboard?.instantiateViewController(identifier: loginVC) as? LoginPageViewController
                                        //view.window?.rootViewController = ss;
                                        //view.window?.makeKeyAndVisible()
                                        
                                    }
                                    catch
                                    {
                                        print("Exception")
                                    }
                                }
                                */
                                
                                
                            }))
                            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        if(user == "Freez")
                        {
                            let alert = UIAlertController(title: "Un-Freez", message: "Do you wanna un-freez \(data.Users)'s account", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
                                action in
                                
                                self.db.collection(email!).document(email!).getDocument { (snapshot, error) in
                                    
                                    let uid = snapshot!.get("\(data.Users) ID") as? String ?? "Nothing found"
                                    
                                    self.db.collection(email!).document(data.Users + " ID: " + data.ID).updateData(["ID":uid])
                                    self.db.collection(email!).document(data.Users + " ID: " + data.ID).updateData(["User":"User"])
                                    self.db.collection(email!).document(email!).getDocument { (snapshot, error) in
                                        var newc = snapshot!.get("UserCount") as? Int ?? 0
                                        newc = newc + 1
                                        self.db.collection(email!).document(email!).updateData(["UserCount":newc])
                                    }
                                    
                                    
                                }
                                
                                
                                
                            }))
                            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                    else
                    {
                        
                    }
                }
            }
            else
            {
                let data = self.structuser[indexPath.row]
                print("\(data.Users): \(data.ID)")
                self.db.collection(email!).document("\(data.Users) ID: \(data.ID)").getDocument { (snapshot, error) in
                    if(error == nil && snapshot != nil)
                    {
                        //let id_ = snapshot!.get("ID") as? String ?? "No ID"
                        let user = snapshot!.get("User") as? String ?? "No user"
                        //print(id_)
                        if(user != "Freez")
                        {
                            let alert = UIAlertController(title: "Freez", message: "Do you wanna freez \(data.Users)'s account", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
                                action in
                                
                                self.db.collection(email!).document(email!).updateData(["\(data.Users) ID":data.ID])
                                
                                //self.db.collection(email!).document(data.Users + " ID: " + data.ID).updateData(["ID":"Freez"])
                                self.db.collection(email!).document(data.Users + " ID: " + data.ID).updateData(["User":"Freez"])
                                self.db.collection(email!).document(email!).getDocument { (snapshot, error) in
                                    
                                    var newc = snapshot!.get("UserCount") as? Int ?? 0
                                    newc = newc - 1
                                    self.db.collection(email!).document(email!).updateData(["UserCount":newc])
                                    /*
                                    var u_count = snapshot!.get("UserCount") as? Int ?? 0
                                    self.db.collection(email!).whereField("User", isEqualTo: "Freez").getDocuments { (snapshot, error) in
                                        if(error == nil && snapshot != nil)
                                        {
                                            for _ in snapshot!.documents
                                            {
                                                u_count = u_count - 1
                                            }
                                            self.db.collection(email!).document(email!).updateData(["UserCount":u_count])
                                        }
                                        else
                                        {
                                            print("Error occured")
                                        }
                                    }
                                    */
                                }
                                
                            }))
                            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        if(user == "Freez")
                        {
                            let alert = UIAlertController(title: "Un-Freez", message: "Do you wanna un-freez \(data.Users)'s account", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
                                action in
                                
                                self.db.collection(email!).document(email!).getDocument { (snapshot, error) in
                                    
                                    //let uid = snapshot!.get("\(data.Users) ID") as? String ?? "Nothing found"
                                    
                                    //self.db.collection(email!).document(data.Users + " ID: " + data.ID).updateData(["ID":uid])
                                    self.db.collection(email!).document(data.Users + " ID: " + data.ID).updateData(["User":"User"])
                                    
                                    self.db.collection(email!).document(email!).getDocument { (snapshot, error) in
                                        var newc = snapshot!.get("UserCount") as? Int ?? 0
                                        newc = newc + 1
                                        self.db.collection(email!).document(email!).updateData(["UserCount":newc])
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                            }))
                            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                    else
                    {
                        
                    }
                }
            }
            
            
            
           
           
          
            
            complition(true)
        }
        swipe.backgroundColor = .systemRed
        let swiped = UISwipeActionsConfiguration(actions: [swipe])
        return swiped
        
    }
}
