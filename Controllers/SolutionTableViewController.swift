//
//  SolutionTableViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 28/06/21.
//
import UIKit
import Firebase

//MARK: - Structure
struct NewSolutionWhole{
    var Solution, Id, Username, Profession, Error, UserID, ProfileSolImg : String
    var Likes: Int
    var Status, SaveFlag:Bool
    var PostedOn:String
}

struct StructSave {
    var SaveStatus:Bool
}

//MARK: - Solution TableViewController
class SolutionTableViewController: UITableViewController, UISearchBarDelegate {

    let refreshControl_ = UIRefreshControl()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    var like_flag = 0;
    
    var lik_count = 0;
    
    var solId = "";
    
    var sortflag = 1;
    
    var searchBarText = ""
    
    var saveFlag = false
    
    var savedOrNot = false
        
    var db = Firestore.firestore()
    
    var structSolution = [NewSolutionWhole]();
    
    var filterStructSolution = [NewSolutionWhole]();
    
    var saveStruct = [StructSave]();
    
    var sortingflag = "";
    
    var listener : ListenerRegistration!
    
    //var lang_id = ""
    //var indexpath = IndexPath
    var ID = "";
    var langName = "";
    var error = "";
    
    
  
    
    @IBOutlet var table_view: UITableView!
    
    // MARK: - ADD Button
    @IBAction func s_add_btn(_ sender: Any)
    {
        performSegue(withIdentifier: "SolutionToAddSolutionSeg", sender: self)
        
    }
    
    // MARK: - Back Button
    @objc func back(sender: UINavigationItem)
    {
        self.performSegue(withIdentifier: "backHomeSegfromS", sender: self)
    }
    
    // MARK: - Refresh
    @IBAction func refreshh(_ sender: UIRefreshControl)
    {
        viewDidLoad()
        sender.endRefreshing()
    }
    
    /*
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        viewDidLoad()
        //table_view.reloadData()
        refreshControl_.endRefreshing()
    }
 */
    
    @objc func disconnectPaxiSocket(_ notification: Notification) {
        print("Printing on Double Tapped")
        
       
        //refreshControl_.attributedTitle = NSAttributedString(string: "Refreshing")
        //refreshControl_.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        //table_view.addSubview(refreshControl_)
        
        
        //viewDidLoad()
        //tableView.reloadData()
        //table_view.clearsContextBeforeDrawing = true
        //table_view.reloadData()
        //let indexPath = IndexPath(row: 0, section: 0)
        //tableView(table_view, cellForRowAt: indexPath)
        //table_view.reloadRows(at: [indexPath], with: .fade)
        
    }
    
    
    //@objc func doubleTapped()
    //{
        
        //displayLikes()
        //print("Double Tapped from Main")
        //get_like_db = UserDefaults.standard.double(forKey: "likes")
        
       // print(get_like_db)
        //print(ID);
        //cpy = get_like_db;
        
        //updateLikes()
        //fetchDoubleLikes()
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        //refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        //fetchLikes()
        
        
       // NotificationCenter.default.post(name: Notification.Name(rawValue: "disconnectPaxiSockets"), object: nil)
        
       
        
        //langName = UserDefaults.standard.string(forKey: "language")!
        //print(ID);
        //print(get_like_db)
        //print(get_like_db);
        //print(langName)
    //}
    
    // MARK: - Sorting
    @IBAction func sort_if_work(_ sender: Any)
    {
        print("Working")
        
        let email = UserDefaults.standard.string(forKey: "email")
        let username = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        
        let alert = UIAlertController(title: "Sort", message: "Select sort style", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Most Likes", style: .default, handler: {
            action in
            self.sortflag = 1
            self.sortingflag = "likes"
            self.db.collection(email!).document(username! + " ID: " + userID!).updateData(["Sort":1])
            self.viewDidLoad()
        }))
        
        alert.addAction(UIAlertAction(title: "Least Likes", style: .default, handler: {
            action in
            self.sortflag = 0
            self.sortingflag = "likes"
            self.db.collection(email!).document(username! + " ID: " + userID!).updateData(["Sort":0])
            self.viewDidLoad()
        }))
        alert.addAction(UIAlertAction(title: "Newest", style: .default, handler: {action in
            self.db.collection(email!).document(username! + " ID: " + userID!).updateData(["DateFlag":true])
            self.sortingflag = "date"
            self.viewDidLoad()
        }))
        alert.addAction(UIAlertAction(title: "Oldest", style: .default, handler: {action in
            self.db.collection(email!).document(username! + " ID: " + userID!).updateData(["DateFlag":false])
            self.sortingflag = "date"
            self.viewDidLoad()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func sortByLike()
   {
        print("Sort like called")
        //self.sortflag = 1;
        //tableView.clearsContextBeforeDrawing = true
        //table_view.clearsContextBeforeDrawing = true
        
        //tableView.reloadData()
        //table_view.reloadData()
        //viewDidLoad()
        //table_view.reloadData()
        //viewDidLoad()
        //viewDidLoad()
   }
    
    //MARK: - Search
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.searchTextField.text = ""
        viewDidLoad()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = searchBarText
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        filterStructSolution = []
        let newsearchtext = searchText.lowercased().components(separatedBy: .whitespacesAndNewlines).joined()
        print(newsearchtext)
        searchController.searchBar.searchTextField.text = searchText
        searchBar.searchTextField.text = searchBarText
        
        if(searchText == "")
        {
            filterStructSolution = structSolution
            //self.tableView.reloadData()
            table_view.reloadData()
        }
        else
        {
            for filterData in structSolution
            {
                if(filterData.Solution.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterStructSolution.append(filterData)
                }
                else if(filterData.Username.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterStructSolution.append(filterData)
                }
                else if(filterData.Profession.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterStructSolution.append(filterData)
                }
                else if(filterData.PostedOn.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterStructSolution.append(filterData)
                }
            }
            print("Filter Data: \(filterStructSolution)")
            //self.tableView.reloadData()
            table_view.reloadData()
            searchController.searchBar.searchTextField.text = searchText
        }
        
        searchBarText = searchText
        searchController.searchBar.searchTextField.text = searchBarText
        //tableView.reloadData()
        table_view.reloadData()
         
    }
    
   
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        structSolution = [];
        filterStructSolution = structSolution
        table_view.reloadData()
        navigationItem.searchController = searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.delegate = self
        
        //popup_update.isHidden = true
        
        
        self.navigationController?.title = "Home"
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(disconnectPaxiSocket(_:)), name: Notification.Name(rawValue: "disconnectPaxiSockets"), object: nil)
        
        
        //NotificationCenter.default.addObserver(self, selector: #selector(sortByLike(_:)), name: Notification.Name(rawValue: "sortByLikes"), object: nil)
        
        //print("Printing on Double Tap")
        
        
        
        self.navigationItem.hidesBackButton = true
        
        //self.tabBarController?.hidesBottomBarWhenPushed = true
        
        
        
        //refreshControl_.attributedTitle = NSAttributedString(string: "Refreshing")
        //refreshControl_.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        //table_view.addSubview(refreshControl_)
        
        
        //let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        //tap.numberOfTapsRequired = 2;
        //table_view.addGestureRecognizer(tap)
        
    
        //let newBackBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(SolutionTableViewController.back(sender:)))
        //self.navigationItem.leftBarButtonItem = newBackBtn
        //newBackBtn.tintColor = .black
        
        self.navigationItem.title = "Solutions"
        
        let email = UserDefaults.standard.string(forKey: "email")
        
        error = UserDefaults.standard.string(forKey: "error")!
        //s_error_disp.text = "Error: " + error

        table_view.dataSource = self
        table_view.delegate = self
        
       
        
       
       
        
    

   
        
        if(like_flag == 0)
        {
            //s_like_label.setImage(UIImage(named: "heart_outline"), for: .normal )
            //fetchLikes()
        }
        else
        {
            //s_like_label.setImage(UIImage(named: "heart_fill")?.withTintColor(.red), for: .normal )
            //fetchLikes()
        }
        
        
        //MARK: - Fetching Data
        ID = UserDefaults.standard.string(forKey: "id")!;
        langName = UserDefaults.standard.string(forKey: "language")!
        let u_sername = UserDefaults.standard.string(forKey: "username") ?? "Guest"
        let userID = UserDefaults.standard.string(forKey: "userId") ?? "11111"
        //let urlstring = UserDefaults.standard.string(forKey: "imageurl")
        
        
        print(email!)
        print(langName)
        print(ID)
        
        
        
        db.collection(email!).document(langName + " ID: " + ID).collection("Solution").whereField("Type", isEqualTo: "Solution").getDocuments { (snapshot, error) in
            
            if(error == nil && snapshot != nil)
            {
                for dataDocument in snapshot!.documents
                {
                    let data = dataDocument.data();
                    let solution = data["SolutionA"] as? String ?? "No Solution found"
                    let id = data["ID"] as? String ?? "NO ID"
                    let userid = data["UserID"] as? String ?? "NO UserID"
                    let likes = data["Likes"] as? Int ?? 0
                    let status = data["Status"] as? Bool ?? false
                    let username = data["Username"] as? String ?? "No name"
                    let profession = data["Profession"] as? String ?? "No Profession"
                    let postedon = data["DateTime"] as? String ?? "No date Specified"
                    let error_ = data["SError"] as? String ?? "No error specified"
                    let saveflag = data["SaveFlag"] as? Bool ?? false
                    let profilesolimg = data["ProfileHomeImg"]as? String ?? "NoImg"
            
                    let newData = NewSolutionWhole(Solution: solution, Id: id, Username: username, Profession: profession,Error: error_, UserID: userid, ProfileSolImg: profilesolimg, Likes: likes, Status: status, SaveFlag: saveflag, PostedOn: postedon);
                    self.structSolution.append(newData);
                    
                    
                    // update likes for user history
                    /*
                    if(u_sername == username)
                    {
                        self.db.collection(email!).document(username + " ID: " + userID).collection("USolution").document("").updateData(["Likes":likes, "Status":true])
                    }
                    */
                    
                    
                }
                //print(self.structSolution)
                
                self.db.collection(email!).document(u_sername + " ID: " + userID).getDocument { (snapshot, error) in
                    if(error == nil && snapshot != nil)
                    {
                        let sort = snapshot!.get("Sort") as? Int ?? 1
                        let time = snapshot?.get("DateFlag") as? Bool ?? false
                        
                       
                        
                        if(time == false)
                        {
                            self.structSolution.sort {$0.PostedOn < $1.PostedOn}
                            self.table_view.reloadData()
                        }
                        else
                        {
                            self.structSolution.sort {$0.PostedOn > $1.PostedOn}
                            self.table_view.reloadData()
                        }
                        if(sort == 1)
                        {
                            self.structSolution.sort { $0.Likes > $1.Likes }
                            print(self.structSolution)
                            self.table_view.reloadData()
                        }
                        else
                        {
                            self.structSolution.sort { $0.Likes < $1.Likes }
                            print(self.structSolution)
                            self.table_view.reloadData()
                        }
                    }
                    print("nothing found")
                    print(self.structSolution.count)
                    
                    //updates likes for userhistory
                    /*
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
                    }
                    */
                    
                    
                }
                
                /*
                if (self.sortflag == 1)
                {
                    self.structSolution.sort { $0.Likes > $1.Likes }
                    print(self.structSolution)
                    self.table_view.reloadData()
                }
                else
                {
                    self.structSolution.sort { $0.Likes < $1.Likes }
                    print(self.structSolution)
                    self.table_view.reloadData()
                }
                */
                //print(self.structSolution.count)
            }
            else
            {
                print("Error occured")
            }
        }
        
        
       
        
        
        
       
        
        
        
        
        DispatchQueue.main.async {
            self.table_view.reloadData()
        }
        
        table_view.reloadData()
        
    
    }

    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener = db.addSnapshotsInSyncListener {
            let email = UserDefaults.standard.string(forKey: "email")
            self.ID = UserDefaults.standard.string(forKey: "id")!;
            self.langName = UserDefaults.standard.string(forKey: "language")!
            let u_sername = UserDefaults.standard.string(forKey: "username") ?? "Guest"
            let userID = UserDefaults.standard.string(forKey: "userId") ?? "11111"
            
            self.db.collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").whereField("Type", isEqualTo: "Solution").getDocuments { (snapshot, error) in
                
                if(error == nil && snapshot != nil)
                {
                    for dataDocument in snapshot!.documents
                    {
                        let data = dataDocument.data();
                        let solution = data["SolutionA"] as? String ?? "No Solution found"
                        let id = data["ID"] as? String ?? "NO ID"
                        let userid = data["UserID"] as? String ?? "NO UserID"
                        let likes = data["Likes"] as? Int ?? 0
                        let status = data["Status"] as? Bool ?? false
                        let username = data["Username"] as? String ?? "No name"
                        let profession = data["Profession"] as? String ?? "No Profession"
                        let postedon = data["DateTime"] as? String ?? "No date Specified"
                        let error_ = data["SError"] as? String ?? "No error specified"
                        let saveflag = data["SaveFlag"] as? Bool ?? false
                        let newData = NewSolutionWhole(Solution: solution, Id: id, Username: username, Profession: profession,Error: error_, UserID: userid, Likes: likes, Status: status, SaveFlag: saveflag, PostedOn: postedon);
                        self.structSolution.append(newData);
                        
                        
                        // update likes for user history
                        /*
                        if(u_sername == username)
                        {
                            self.db.collection(email!).document(username + " ID: " + userID).collection("USolution").document("").updateData(["Likes":likes, "Status":true])
                        }
                        */
                        
                        
                    }
                    //print(self.structSolution)
                    
                    self.db.collection(email!).document(u_sername + " ID: " + userID).getDocument { (snapshot, error) in
                        if(error == nil && snapshot != nil)
                        {
                            let sort = snapshot!.get("Sort") as? Int ?? 1
                            let time = snapshot?.get("DateFlag") as? Bool ?? false
                            
                           
                            
                            if(time == false)
                            {
                                self.structSolution.sort {$0.PostedOn < $1.PostedOn}
                                self.table_view.reloadData()
                            }
                            else
                            {
                                self.structSolution.sort {$0.PostedOn > $1.PostedOn}
                                self.table_view.reloadData()
                            }
                            if(sort == 1)
                            {
                                self.structSolution.sort { $0.Likes > $1.Likes }
                                print(self.structSolution)
                                self.table_view.reloadData()
                            }
                            else
                            {
                                self.structSolution.sort { $0.Likes < $1.Likes }
                                print(self.structSolution)
                                self.table_view.reloadData()
                            }
                        }
                        print("nothing found")
                        print(self.structSolution.count)
                        
                        //updates likes for userhistory
                        /*
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
                        }
                        */
                        
                        
                    }
                    
                    /*
                    if (self.sortflag == 1)
                    {
                        self.structSolution.sort { $0.Likes > $1.Likes }
                        print(self.structSolution)
                        self.table_view.reloadData()
                    }
                    else
                    {
                        self.structSolution.sort { $0.Likes < $1.Likes }
                        print(self.structSolution)
                        self.table_view.reloadData()
                    }
                    */
                    //print(self.structSolution.count)
                }
                else
                {
                    print("Error occured")
                }
            }
        }
    }
     */
    /*
    override func viewWillDisappear(_ animated: Bool) {
        listener.remove()
    }
     */
    
    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if(!filterStructSolution.isEmpty)
        {
            return 1
        }
        else
        {
            return 1
        }
        
    }
     */
    // MARK: - Numbers of Rows in Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if(!filterStructSolution.isEmpty)
        {
            print("Count: \(filterStructSolution.count)")
            return filterStructSolution.count;
        }
        else
        {
            print(structSolution.count)
            return structSolution.count;
        }
       
    }

    // MARK: - Cell data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //tableView.reloadData()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewSolutionTableViewCell
        
        //let email = UserDefaults.standard.string(forKey: "email")
        //let u_sername = UserDefaults.standard.string(forKey: "username")
        //let userID = UserDefaults.standard.string(forKey: "userId")
        
        
        let email = UserDefaults.standard.string(forKey: "email")
        let u_sername = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        ID = UserDefaults.standard.string(forKey: "id")!;
        langName = UserDefaults.standard.string(forKey: "language")!
        
        
        
        //MARK:- Data after Searching
        if(!filterStructSolution.isEmpty)
        {
            let data = filterStructSolution[indexPath.row]
            //let saveData = saveStruct[indexPath.row]
            
            cell.data_label.text = "Solution: \(data.Solution)";
            cell.posted_on.text = "Posted on: \(data.PostedOn)"
            
            //let task_ = URLSession.shared.dataTask(with: data.ImageUrl!)
            
            //Image
            //MARK:- Main Solution IMAGE
            /*
            db.collection(email!).document(data.Username + " ID: " + data.UserID).getDocument { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    let pimg_ = snapshot?.get("ImageUrl")as? String ?? "Novalues" ;
                    //self.db.collection(email!).document(data.Language + " ID: " + data.Id).updateData(["ProfileHomeImg":pimg_]);
                    self.db.collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).updateData(["ProfileHomeImg":pimg_]);
                    
                    //Downloading image and setting it
                   
                    print("imageurl: \(pimg_ )")
                    let url_ = URL(string: pimg_ )!
                    
                    let task = URLSession.shared.dataTask(with: url_, completionHandler: {data, _, error in
                        
                        guard let data = data, error == nil else{
                            return
                        }
                        DispatchQueue.main.async{
                            let image = UIImage(data: data)
                            cell.solImg.image = image
                        }
                    })
                    task.resume()
                }
            }
            */
            
            if(data.Likes >= 0 && data.Status == true)
            {
                cell.get_like_db = data.Likes
                cell.like_flag = 1
                cell.s_username_label.text = "Username: \(data.Username)"
                cell.s_profession_label.text = "Profession: \(data.Profession)"
                cell.like_btn_Llabel.setImage(UIImage(named: "heart_fill")?.withTintColor(.red),  for: .normal )
                cell.likes_label.text = String(data.Likes)
                
                //Image
                
                
                
            }
            
            else if(data.Likes >= 0 && data.Status == false)
            {
               
                cell.like_btn_Llabel.setImage(UIImage(named: "heart_outline"), for: .normal )
                cell.get_like_db = data.Likes
                cell.s_username_label.text = "Username: \(data.Username)"
                cell.s_profession_label.text = "Profession: \(data.Profession)"
                cell.likes_label.text = String(data.Likes)
                cell.like_flag = 0
                
            }
            
            //New way fetch save
            db.collection(email!).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + data.Id).collection("Save").document(u_sername! + " ID: " + userID!).getDocument { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    print("GOING IN")
                    let saveflag_ = snapshot?.get("SaveFlag") as? Bool ?? false
                    if(saveflag_ == true)
                    {
                        cell.save_btn_label.setImage(UIImage(named: "saveFilled")?.withTintColor(.blue), for: .normal)
                        cell.save_btn_flag = 1
                    }
                    else if(saveflag_ == false)
                    {
                        cell.save_btn_label.setImage(UIImage(named: "save"), for: .normal)
                        cell.save_btn_flag = 0;
                    }
                }
            }
            
            /*
            if(data.SaveFlag == true)
            {
                cell.save_btn_label.setImage(UIImage(named: "saveFilled")?.withTintColor(.blue), for: .normal)
                cell.save_btn_flag = 1
            }
            else if(data.SaveFlag == false)
            {
                cell.save_btn_label.setImage(UIImage(named: "save"), for: .normal)
                cell.save_btn_flag = 0;
            }
            */
            /*
            if(saveData.SaveStatus == false)
            {
                cell.save_btn_label.setImage(UIImage(named: "bookmark"), for: .normal)
            }
            else
            {
                cell.save_btn_label.setImage(UIImage(named: "bookmark.fill"), for: .normal)
            }
            */
            //cell.s_like_tapped.setImage(UIImage(named: "heart_fill")?.withTintColor(.red), for: .normal )
            
            //cell.s_like_label.text = "20"
        }
        
        //MARK:- Data before searching
        else
        {
            //var st = false
            let data = structSolution[indexPath.row]
            //let saveData = saveStruct[indexPath.row]
            
            cell.data_label.text = "Solution: \(data.Solution)";
            cell.posted_on.text = "Posted on: \(data.PostedOn)";
            
            /*
            //Image
            let pimg_ = data.ProfileSolImg;
            self.db.collection(email!).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + data.Id).updateData(["ProfileHomeImg":pimg_]);
            
            //Downloading image and setting it
           
            print("imageurl: \(pimg_ )")
            let url_ = URL(string: pimg_ )!
            
            let task = URLSession.shared.dataTask(with: url_, completionHandler: {data, _, error in
                
                guard let data = data, error == nil else{
                    return
                }
                DispatchQueue.main.async{
                    let image = UIImage(data: data)
                    cell.solImg.image = image
                }
            })
            task.resume()
            */
            //MARK:- Main Solution IMAGE
            /*
            db.collection(email!).document(data.Username + " ID: " + data.UserID).getDocument { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    let pimg_ = snapshot?.get("ImageUrl")as? String ?? "Novalues" ;
                    //self.db.collection(email!).document(data.Language + " ID: " + data.Id).updateData(["ProfileHomeImg":pimg_]);
                    self.db.collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).updateData(["ProfileHomeImg":pimg_]);
                    
                    //Downloading image and setting it
                   
                    print("imageurl: \(pimg_ )")
                    let url_ = URL(string: pimg_ )!
                    
                    let task = URLSession.shared.dataTask(with: url_, completionHandler: {data, _, error in
                        
                        guard let data = data, error == nil else{
                            return
                        }
                        DispatchQueue.main.async{
                            let image = UIImage(data: data)
                            cell.solImg.image = image
                        }
                    })
                    task.resume()
                }
            }
            */
            

            
           
            
            db.collection(email!).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + data.Id).collection("Likes").document(u_sername! + " ID: " + userID!).getDocument { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    let status = snapshot!.get("Status") as? Bool ?? false
                    
                    if(data.Likes >= 0 && status == true)
                    {
                        cell.get_like_db = data.Likes
                        cell.like_flag = 1
                        cell.s_username_label.text = "Username: \(data.Username)"
                        cell.s_profession_label.text = "Profession: \(data.Profession)"
                        
                        cell.like_btn_Llabel.setImage(UIImage(named: "heart_fill")?.withTintColor(.red),  for: .normal )
                    
                        cell.likes_label.text = String(data.Likes)
                        
                        
                    }
                    
                    
                   
                    else if(data.Likes >= 0 && status == false)
                    {
                       
                        cell.like_btn_Llabel.setImage(UIImage(named: "heart_outline"), for: .normal )
                        cell.get_like_db = data.Likes
                        cell.s_username_label.text = "Username: \(data.Username)"
                        cell.s_profession_label.text = "Profession: \(data.Profession)"
                        cell.likes_label.text = String(data.Likes)
                        cell.like_flag = 0
                        
                    }
                    
                    print("NOT GOING IN")
                    //new way to fetch save
                    self.db.collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).collection("Save").document(u_sername! + " ID: " + userID!).getDocument { (snapshot, error) in
                        if(error == nil && snapshot != nil)
                        {
                            print("GOING IN")
                            let saveflag_ = snapshot?.get("SaveFlag") as? Bool ?? false
                            if(saveflag_ == true)
                            {
                                cell.save_btn_label.setImage(UIImage(named: "saveFilled")?.withTintColor(.blue), for: .normal)
                                cell.save_btn_flag = 1
                            }
                            else if(saveflag_ == false)
                            {
                                cell.save_btn_label.setImage(UIImage(named: "save"), for: .normal)
                                cell.save_btn_flag = 0;
                            }
                        }
                    }
                    
                }
                else
                {
                    print("Error Occured")
                }
            }
            
            
            
            //undo after if needed again
            
           
            
            
            
            
            
            /*
            if(data.SaveFlag == true)
            {
                cell.save_btn_label.setImage(UIImage(named: "saveFilled")?.withTintColor(.blue), for: .normal)
                cell.save_btn_flag = 1
            }
            else if(data.SaveFlag == false)
            {
                cell.save_btn_label.setImage(UIImage(named: "save"), for: .normal)
                cell.save_btn_flag = 0;
            }
             */
            
            //
            /*
            if(saveData.SaveStatus == false)
            {
                cell.save_btn_label.setImage(UIImage(named: "bookmark"), for: .normal)
            }
            else
            {
                cell.save_btn_label.setImage(UIImage(named: "bookmark.fill"), for: .normal)
            }
            */
            //cell.s_like_tapped.setImage(UIImage(named: "heart_fill")?.withTintColor(.red), for: .normal )
            
            //cell.s_like_label.text = "20"
            
        }

       
        return cell;
    }
    
    
    // MARK: - Row Selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        //MARK:- Data after searchinf
        if(!filterStructSolution.isEmpty)
        {
            let data = filterStructSolution[indexPath.row]
            print("Selected \(indexPath.row)")
            
            UserDefaults.standard.setValue(data.Id, forKey: "sid")
            UserDefaults.standard.setValue(data.Username, forKey: "s_u_sername")
            UserDefaults.standard.setValue(data.UserID, forKey: "puid")
            UserDefaults.standard.setValue(data.Profession, forKey: "p_pro")
            print("STVID: \(data.Id) \(data.Username)")
            
            //print("SUsername: \(data.Username)")
        }
        //MARK:- Data before searching
        else
        {
            let data = structSolution[indexPath.row]
            print("Selected \(indexPath.row)")
            UserDefaults.standard.setValue(data.Id, forKey: "sid")
            UserDefaults.standard.setValue(data.Username, forKey: "s_u_sername")
            UserDefaults.standard.setValue(data.UserID, forKey: "puid")
            UserDefaults.standard.setValue(data.Profession, forKey: "p_pro")
            print("STVID: \(data.Id)")
            print("SUsername: \(data.Username)")
        }
        
    }
    
    //MARK:- On Swipe
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
      
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewSolutionTableViewCell
        
        let date = Date()
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        timeFormatter.dateFormat = "HH:mm:ss"
        let Date = dateFormatter.string(from: date)
        let Time = timeFormatter.string(from: date)
        let dateTime = Date + " " + Time
        
        let email = UserDefaults.standard.string(forKey: "email")
        let u_sername = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        ID = UserDefaults.standard.string(forKey: "id")!;
        langName = UserDefaults.standard.string(forKey: "language")!
        
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
        
        //update feature
        
        
        let update = UIContextualAction(style: .normal, title: "Update") { (action, view, completionHandler) in
            print("Update working fine")
            //self.popup_update.isHidden = false
            //NotificationCenter.default.post(name: Notification.Name(rawValue: "SwipedForUpdate"), object: nil)
            completionHandler(true)
        }
        
       
        
        
        
        
        
        //Copy
        
        let copy = UIContextualAction(style: .normal, title: "Copy") {
            (action, view, completionHandler) in
            print("Copy working fine")
            
            if(!self.filterStructSolution.isEmpty)
            {
                let data = self.filterStructSolution[indexPath.row]
                self.db.collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).getDocument { (snapshot, error) in
                    if(error == nil && snapshot != nil)
                    {
                        //print("SID \(SID_!)")
                        let sol = snapshot!.get("SolutionA") as? String ?? "no sol found"
                        
                        let alert = UIAlertController(title: "Copy", message: "Copy solution", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                            UIPasteboard.general.string = sol
                        }))
                        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else
                    {
                        print("Error occured")
                    }
                }
            }
            else
            {
                let data = self.structSolution[indexPath.row]
                self.db.collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).getDocument { (snapshot, error) in
                    if(error == nil && snapshot != nil)
                    {
                        //print("SID \(SID_!)")
                        let sol = snapshot!.get("SolutionA") as? String ?? "no sol found"
                        
                        let alert = UIAlertController(title: "Copy", message: "Copy solution", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                            UIPasteboard.general.string = sol
                        }))
                        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else
                    {
                        print("Error occured")
                    }
                }
            }
           
            
            
            
            
            
            
            
            completionHandler(true)
        }
        
        
        
        
        
        
        
        
        //Save
        
        let save = UIContextualAction(style: .normal, title: "Save", handler: {
            (action,view,completionHandler) in
            
            if(!self.filterStructSolution.isEmpty)
            {
                
                let data = self.filterStructSolution[indexPath.row]
                
                //for save and unsave new method
                self.db.collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).collection("Save").document(u_sername! + " ID: " + userID!).getDocument { (snapshot, error) in
                    if(error == nil && snapshot != nil)
                    {
                       
                        let saveflag_ = snapshot?.get("SaveFlag") as? Bool ?? false
                        if(saveflag_ == false)
                        {
                            let alert  = UIAlertController(title: "Save", message: "Do you want to save?", preferredStyle: .alert)
                                
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                                //cell.save_btn_label.setImage(UIImage(named: "bookmark.fill"), for: .normal)
                                print("Solution swipe working \(indexPath.row)")
                                    
                                    
                                self.db.collection(email!).document(u_sername! + " ID: " + userID!).collection("Save").document("SaveID: " + data.Id).setData(["SaveFlag":true, "SUError":data.Error, "SUSolution":data.Solution, "SUSUsername":data.Username, "Date":data.PostedOn, "SUSDate":dateTime, "Type":"Saved", "SaveID":data.Id, "LangName":self.langName, "LangId":self.ID])
                                
                                self.db.collection(email!).document(u_sername! + " ID: " + userID!).collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).updateData(["SaveFlag":true])
                                
                                //Save in general
                                self.db.collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).collection("Save").document(u_sername! + " ID: " + userID!).setData(["SaveFlag":true, "Username":u_sername!, "UserID":userID!,"Type":"Save", "Date":dateTime])
                                
                                self.saveFlag = true
                                self.savedOrNot = true
                                    
                                    
                                //NotificationCenter.default.post(name: Notification.Name(rawValue: "swipedForSave"), object: nil)
                                    
                                self.viewDidLoad()
                                tableView.reloadData()
                            
                               
                                //tableView.reloadData()
                                   
                                    
                            }))
                                
                            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                                
                            self.present(alert, animated: true, completion: nil)
                        }
                       
                        else
                        {
                            
                            let alert  = UIAlertController(title: "Un-Save", message: "Do you want to Un-save?", preferredStyle: .alert)
                                
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                                //cell.save_btn_label.setImage(UIImage(named: "bookmark.fill"), for: .normal)
                                print("Solution swipe working \(indexPath.row)")
                                    
                                    
                                self.db.collection(email!).document(u_sername! + " ID: " + userID!).collection("Save").document("SaveID: " + data.Id).delete()
                                
                                self.db.collection(email!).document(u_sername! + " ID: " + userID!).collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).updateData(["SaveFlag":false])
                                
                                self.db.collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).collection("Save").document(u_sername! + " ID: " + userID!).updateData(["SaveFlag":false])
                                
                                self.saveFlag = true
                                self.savedOrNot = true
                                    
                                    
                                //NotificationCenter.default.post(name: Notification.Name(rawValue: "swipedForSave"), object: nil)
                                    
                                self.viewDidLoad()
                                tableView.reloadData()
                               
                                
                                //tableView.reloadData()
                                   
                                    
                            }))
                                
                            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                                
                            self.present(alert, animated: true, completion: nil)

                        }
                           
                    }
                }
                
                
                
                
                
                    
                
                
               
                
            }
            
            
            else
            {
                //let saveData = self.saveStruct[indexPath.row]
                
                //var saveflag_ = false
                let data = self.structSolution[indexPath.row]
                
                self.db.collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).collection("Save").document(u_sername! + " ID: " + userID!).getDocument { (snapshot, error) in
                    if(error == nil && snapshot != nil)
                    {
                       
                        let saveflag_ = snapshot?.get("SaveFlag") as? Bool ?? false
                        if(saveflag_ == false)
                        {
                    
                            let alert  = UIAlertController(title: "Save", message: "Do you want to save?", preferredStyle: .alert)
                                
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                                //cell.save_btn_label.setImage(UIImage(named: "bookmark.fill"), for: .normal)
                                print("Solution swipe working \(indexPath.row)")
                                    
                                    
                                self.db.collection(email!).document(u_sername! + " ID: " + userID!).collection("Save").document("SaveID: " + data.Id).setData(["SaveFlag":true, "SUError":data.Error, "SUSolution":data.Solution, "SUSUsername":data.Username, "Date":data.PostedOn, "SUSDate":dateTime, "Type":"Saved", "SaveID":data.Id, "LangName":self.langName, "LangId":self.ID])
                                
                                self.db.collection(email!).document(u_sername! + " ID: " + userID!).collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).updateData(["SaveFlag":true])
                                
                                self.db.collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).collection("Save").document(u_sername! + " ID: " + userID!).setData(["SaveFlag":true, "Username":u_sername!, "UserID":userID!,"Type":"Save", "Date":dateTime])
                                
                                self.saveFlag = true
                                self.savedOrNot = true
                                    
                                    
                                //NotificationCenter.default.post(name: Notification.Name(rawValue: "swipedForSave"), object: nil)
                                
                                self.viewDidLoad()
                                tableView.reloadData()
                                   
                                    
                            }))
                                
                            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                                
                            self.present(alert, animated: true, completion: nil)
                        }
                       
                        else if(saveflag_ == true)
                        {
                            let alert  = UIAlertController(title: "Un-Save", message: "Do you want to Un-save?", preferredStyle: .alert)
                                
                            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                                //cell.save_btn_label.setImage(UIImage(named: "bookmark.fill"), for: .normal)
                                print("Solution swipe working \(indexPath.row)")
                                    
                                    
                                self.db.collection(email!).document(u_sername! + " ID: " + userID!).collection("Save").document("SaveID: " + data.Id).delete()
                                
                                self.db.collection(email!).document(u_sername! + " ID: " + userID!).collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).updateData(["SaveFlag":false])
                                
                                self.db.collection(email!).document(self.langName + " ID: " + self.ID).collection("Solution").document("Solution ID: " + data.Id).collection("Save").document(u_sername! + " ID: " + userID!).updateData(["SaveFlag":false])
                                
                                self.saveFlag = true
                                self.savedOrNot = true
                                    
                                    
                                //NotificationCenter.default.post(name: Notification.Name(rawValue: "swipedForSave"), object: nil)
                               
                                self.viewDidLoad()
                                tableView.reloadData()
                                   
                                    
                            }))
                                
                            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
                                
                            self.present(alert, animated: true, completion: nil)

                        }

                           
                    }
                }
                
                                
               
                
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
        
        update.backgroundColor = .systemGreen
        update.image = UIImage(named: "update")?.withTintColor(.white)
        
        copy.backgroundColor = .systemPink
        copy.image = UIImage(named: "copy_")?.withTintColor(.white)
        
      
        save.backgroundColor = .blue
        save.image = UIImage(named: "saveFilled")?.withTintColor(.white)
        let swipe = UISwipeActionsConfiguration(actions: [save,copy,update])
        return swipe
    }
    
    /*
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        timeFormatter.dateFormat = "HH:mm:ss"
        let Date = dateFormatter.string(from: date)
        let Time = timeFormatter.string(from: date)
        let dateTime = Date + " " + Time
        
        let email = UserDefaults.standard.string(forKey: "email")
        let u_sername = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        ID = UserDefaults.standard.string(forKey: "id")!;
        langName = UserDefaults.standard.string(forKey: "language")!
        
        let dd = structSolution[indexPath.row]
        if(dd.Username == u_sername)
        {
            let update_ = UIContextualAction(style: .normal, title: "Update") { (action, view, completionHandler) in
                print("Update working fine")
                //self.popup_update.isHidden = false
                NotificationCenter.default.post(name: Notification.Name(rawValue: "SwipedForUpdate"), object: nil)
                completionHandler(true)
                
                
                
               
            }
            update_.backgroundColor = .systemGreen
            update_.image = UIImage(named: "update")?.withTintColor(.white)
            let update_ = UISwipeActionsConfiguration(actions: [update_])
            //
        }
        
       
    }
     */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK:- Tabbar
extension SolutionTableViewController: UITabBarDelegate, UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if(tabBarIndex == 0)
        {
            print("Solution Home called")
            //table_view.reloadData()
            //view.reloadInputViews()
            //table_view.reloadData()
            table_view.reloadData()
            viewDidLoad()
            //table_view.reloadData()
        }
        if(tabBarIndex == 1)
        {
            print("Solution Notification called")
            //NotificationCenter.default.post(name: Notification.Name(rawValue: "ReloadPage"), object: nil)
            table_view.reloadData()
            viewDidLoad()
        }
        if(tabBarIndex == 2)
        {
            print("Solution Profile called")
            table_view.reloadData()
            viewDidLoad()
        }
    }
    
    
}

