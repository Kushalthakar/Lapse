//
//  HomeViewController.swift
//  StartUpIdea1
// Asdasdas
//  Created by Kushal Thakar on 06/06/21.
//
//
import UIKit
import Firebase


//MARK: - Structure
struct Whole {
    var Error, Solution, Language, Id, Username, UserID, Profession, ImageUrl,ProfileHomeImg : String
    var Likes, Homelikes:Int
    var Status: Bool
    var PostedOn: String
}

struct OnlyLikes {
    var HLikes:Int
}
//struct Solutions {
   // var solution : String
//}
struct ForTotalLikes {
    //var Username,Profession : String
    var Likes : Int
}
//MARK: - HomeViewController
class HomeViewController: UIViewController, UISearchBarDelegate{
    
    //var str = [data]()
    let db = Firestore.firestore()
    
    var errorAndsolution = [Whole]();
    
    var filterDataES = [Whole]();
    
    var homeLikes = [OnlyLikes]();
    
    var filterHomeLikes = [OnlyLikes]();
    
    var structForTotalLikes = [ForTotalLikes]()
    
    //var solution = [Solutions]();
    
    let refreshControl = UIRefreshControl()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    var strError = ""
    
    var sum = 0;
    
    var searchBarText = ""
    
    //var flage = 0;
    
    
    
    @IBOutlet weak var menu_view_design: UIView!
    
    @IBOutlet weak var table_view: UITableView!
    
    
    @IBOutlet weak var like_btn_h_label: UIButton!
    
    @IBOutlet weak var like_count_h_label: UILabel!
    
    @IBOutlet weak var username_label: UILabel!
    
    
   
    @IBOutlet weak var menuView: UIView!
    
    var menuViewFlag = false
    
    
   
    @IBOutlet weak var menuTrailing: NSLayoutConstraint!
    
    
    
    //@IBOutlet weak var like_count: UILabel!
    
    //@IBOutlet weak var like_btn_tapped: UIButton!
    
    //@IBAction func like_btn_action(_ sender: Any)
    
    /*
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        searchBarText = searchText;
        print(searchBarText)
        if(searchText == "")
        {
            print("Print text")
        }
    }
    */
    
    //MARK: - Menu btn
    @IBAction func menu_btn(_ sender: Any)
    {
        /*
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy HH:mm:ss"
        let result = formatter.string(from: date)
        let calander = Calendar.current
        let hour = calander.component(.hour, from: date)
        let minutes = calander.component(.minute, from: date)
        */
        
        
        let date = Date()
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        timeFormatter.dateFormat = "HH:mm:ss"
        let Date = dateFormatter.string(from: date)
        let Time = timeFormatter.string(from: date)
        let dateTime = Date + " " + Time
        
        print("Date: \(Date)")
        print("Time: \(Time)")
        print("Result: \(dateTime)")
        //print("Calander: \(calander)")
        //print("Hour: \(hour):\(minutes)")
        //print("minute \(minutes)")
        
        /*
        //performSegue(withIdentifier: "HtoMenuSeg", sender: self)
        if menuViewFlag == false
        {
            menuTrailing.constant = 600
            menuViewFlag = true
        }
        else
        {
            menuTrailing.constant = 850
            menuViewFlag = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: self.view.layoutIfNeeded) { (animatinComplete) in
            print("The Animation is complete")
        }
        */
    }
    
   
    
    //MARK: - Add Btn
    @IBAction func add_btn(_ sender: Any)
    {
        performSegue(withIdentifier: "addSeg", sender: self)
    }
    
    //MARK: - Sort Btn
    @IBAction func home_sort(_ sender: Any)
    {
        
        let email = UserDefaults.standard.string(forKey: "email")
        let Husername = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        
        let alert = UIAlertController(title: "Sort", message: "Select sort style", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Most Likes", style: .default, handler: {
            action in
            //self.sortflag = 1
            
            self.db.collection(email!).document(Husername! + " ID: " + userID!).updateData(["HomeSort":1])
            self.viewDidLoad()
        }))
        
        alert.addAction(UIAlertAction(title: "Least Likes", style: .default, handler: {
            action in
            //self.sortflag = 0
            self.db.collection(email!).document(Husername! + " ID: " + userID!).updateData(["HomeSort":0])
            self.viewDidLoad()
        }))
        alert.addAction(UIAlertAction(title: "Newest", style: .default, handler: {action in
            self.db.collection(email!).document(Husername! + " ID: " + userID!).updateData(["HomeDateFlag":true])
            //self.sortingflag = "date"
            self.viewDidLoad()
        }))
        alert.addAction(UIAlertAction(title: "Oldest", style: .default, handler: {action in
            self.db.collection(email!).document(Husername! + " ID: " + userID!).updateData(["HomeDateFlag":false])
            //self.sortingflag = "date"
            self.viewDidLoad()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    //MARK: - Refresh
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        viewDidLoad()
        refreshControl.endRefreshing()
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
        //let newsearchtext = searchText.trimmingCharacters(in: .whitespaces).lowercased()
        //let newsearchtext = String(searchText.filter({!"\n\t\r".contains($0)}))
        let newsearchtext = searchText.lowercased().components(separatedBy: .whitespacesAndNewlines).joined()
        filterDataES = []
        //searchController.searchBar.searchTextField.text = searchText
        print(newsearchtext)
        searchController.searchBar.searchTextField.text = newsearchtext
        if searchText == ""
        {
            filterDataES = errorAndsolution
            table_view.reloadData()
        
        }
        else
        {
            
           
            for filterData in errorAndsolution
            {
                
                if (filterData.Language.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    print("Filterdate \(filterData.Language)")
                    print("search text \(newsearchtext)")
                    filterDataES.append(filterData)
                }
                else if(filterData.Error.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterDataES.append(filterData)
                }
                else if(filterData.Username.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterDataES.append(filterData)
                }
                else if(filterData.Profession.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterDataES.append(filterData)
                }
                else if(filterData.PostedOn.lowercased().components(separatedBy: .whitespacesAndNewlines).joined().contains(newsearchtext))
                {
                    filterDataES.append(filterData)
                }
                
                
            }
            
            print("Home Filter Data: \(filterDataES)")
            table_view.reloadData()
            searchController.searchBar.searchTextField.text = searchText
            
        }
        searchBarText = searchText
        searchController.searchBar.searchTextField.text = searchBarText
        table_view.reloadData()
    }
    
    /*
    @objc func homeTabBar()
    {
        print("Home Tab bar Clicked")
    }
    */
    
    
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.searchController = searchController
        
        
        //navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        //searchController.navigationItem.hidesSearchBarWhenScrolling = false
        
        
        //searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.delegate = self
        
        self.navigationController?.title = "Home"
        
        //let homeItem = UITapGestureRecognizer(target:self, action: #selector(homeTabBar))
        //homeItem.numberOfTapsRequired = 1
        //tabBarController?.tabBar.addGestureRecognizer(homeItem)
        
       
        menuView.layer.borderWidth = 0.5
        
        //navigationItem.backBarButtonItem?.isEnabled = false
        
        //navigationItem.leftBarButtonItem?.isEnabled = false
        
        //self.navigationItem.hidesBackButton = true
        
      
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        table_view.addSubview(refreshControl)
        
        
        //self.navigationItem.setHidesBackButton(true, animated: true)
        //self.navigationItem.backBarButtonItem?.isEnabled = false;
        errorAndsolution = [];
        
        filterDataES = errorAndsolution
        filterHomeLikes = homeLikes
        
        //homeLikes = []
        
        table_view.reloadData();
        
        table_view.delegate = self
        table_view.dataSource = self
        tabBarController?.delegate = self
        /*
        self.table_view.estimatedRowHeight = 50;
        self.table_view.estimatedSectionHeaderHeight = 50;
        self.table_view.estimatedSectionFooterHeight = 50;
        */
        //MARK: - Fetching Data
        let email = UserDefaults.standard.string(forKey: "email")
        let Husername = UserDefaults.standard.string(forKey: "username") ?? "Guest"
        let Hprofession = UserDefaults.standard.string(forKey: "profession") ?? "p"
        let userID = UserDefaults.standard.string(forKey: "userId") ?? "12345"
        
        //searchController.searchBar.searchTextField.text = "jjjjj"
    
        searchController.searchBar.searchTextField.text = searchBarText
        /*
        db.collection(email!).document(email!).getDocument { (snapshot, error) in
            var count = snapshot!.get("Count") as? Int ?? 0
            if(count > 2)
            {
                
                count = count - 1
                self.db.collection(email!).document(email!).updateData(["Count":count])
                do
                {
                    try Auth.auth().signOut()
                }
                catch
                {
                    print("Error")
                }
                
                self.performSegue(withIdentifier: "htolseg", sender: self)
                
            }
            else
            {
                print("nothing happened")
            }
                
            
        }
       
        */
        
        //Image Of Profile on Home
        
        
        
        
        if(Husername == "Guest" && userID == "12345" && Hprofession == "p")
        {
            print("First Update user profile")
            self.navigationItem.hidesBackButton = true
            performSegue(withIdentifier: "HomeToUpdateUserSeg", sender: self)
        }
        else
        {
            db.collection(email!).whereField("Type", isEqualTo: "Error").getDocuments{ (snapshot, error) in
                if error == nil  && snapshot != nil
                {
                    guard let snap = snapshot else {return}
                    
                    for documents in snap.documents
                    {
                        let data = documents.data();
                        let id = data["ID"] as? String ?? "Id not found";
                        let errors = data["Error"] as? String ?? "Nothing in database";
                        let solution = data["Solution"] as? String ?? "Nothing in database";
                        let lang = data["Language"] as? String ?? "NO language"
                        let likes = data["Likes"] as? Int ?? 0
                        let status = data["Status"] as? Bool ?? false
                        let username = data["Username"] as? String ?? "No Username"
                        let userid = data["UserID"] as? String ?? "No Id"
                        let profession = data["Profession"] as? String ?? "No Profession"
                        let homelikes = data["HomeLikes"] as? Int ?? 0
                        let postedon = data["DateTime"] as? String ?? "No date specified"
                        let image = data["ImageUrl"] as? String ?? "Image url"
                        let profileImgUrl = data["ProfileHomeImg"] as? String ?? "ProfileHomeImg"
                        let newData = Whole(Error: errors, Solution: solution, Language: lang, Id: id, Username: username,UserID: userid, Profession: profession,ImageUrl: image,ProfileHomeImg: profileImgUrl, Likes: likes, Homelikes: homelikes, Status: status, PostedOn: postedon);
                        self.errorAndsolution.append(newData);
                        
                        
                        //_ = 0;
                        //Sorting
                        
                        self.db.collection(email!).document(Husername + " ID: " + userID).getDocument { (snapshot, error) in
                            if(error == nil && snapshot != nil)
                            {
                                let sort = snapshot!.get("HomeSort") as? Int ?? 1
                                let time = snapshot?.get("HomeDateFlag") as? Bool ?? false
                                
                                if(time == false)
                                {
                                    self.errorAndsolution.sort {$0.PostedOn < $1.PostedOn}
                                    self.table_view.reloadData()
                                }
                                else
                                {
                                    self.errorAndsolution.sort {$0.PostedOn > $1.PostedOn}
                                    self.table_view.reloadData()
                                }
                                if(sort == 1)
                                {
                                    self.errorAndsolution.sort { $0.Homelikes > $1.Homelikes }
                                    //print(self.errorAndsolution)
                                    self.table_view.reloadData()
                                }
                                else
                                {
                                    self.errorAndsolution.sort { $0.Homelikes < $1.Homelikes }
                                    //print(self.structSolution)
                                    self.table_view.reloadData()
                                }
                            }
                            else
                            {
                                print("Nothing found")
                            }
                        }
                        
                        
                        
                        
                        
                        
                        
                    }
                    print(self.errorAndsolution);
                    print(self.homeLikes)
                    //print("ALLLLL LIkes: \(self.homeLikes)" )
                    //self.table_view.reloadData()
                }
            }
            
            
            //MARK:- Leaderboard
            //leaderboard
            //
            print("Not going in")
            db.collection(email!).document(Husername + " ID: " + userID).collection("Nlikes").whereField("Type", isEqualTo: "NLikes").getDocuments { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    var sum = 0
                    for documents in snapshot!.documents
                    {
                        let data = documents.data()
                        let likes = data["Likes"] as? Int ?? 0
                        let ulname = data["LikedBy"] as? String ?? "no name found"
                        if(ulname == Husername)
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
                   
                    let newdata = ForTotalLikes(Likes:sumLikes)
                    self.structForTotalLikes.append(newdata)
                    
                    if(Husername == "Guest")
                    {
                        
                    }
                    else
                    {
                        self.db.collection(email!).document("Leaderboard").collection("TotalLikes").document(Husername + " ID: " + userID).setData(["Type":"TotalLikes", "Likes":sum,"Name":Husername, "Profession":Hprofession])
                    }
                    
                }
                else
                {
                    print("Error")
                }
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            /*
            let email = UserDefaults.standard.string(forKey: "email")
            
            let username = UserDefaults.standard.string(forKey: "username") ?? "Guest"
            
            //let profession = UserDefaults.standard.string(forKey: "profession")
            
            let uid = UserDefaults.standard.string(forKey: "userId") ?? "11111"
            
            let ID = UserDefaults.standard.string(forKey: "id")!;
            let langName = UserDefaults.standard.string(forKey: "language")!
            
            //db.collection(email!).document(username! + " ID: " + uid!).collection(email!).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + random).setData(["Type":"Solution", "SolutionA":ans_txt, "ID":random, "Likes":likes, "Status":false,"Username":username!, "Profession":profession!, "DateTime":dateTime, "Date":Date, "Time":Time, "SError":error_txt, "Reason":reason1, "SaveFlag":false])
            if(username == "Guest")
            {
                print("Guest Mode")
            }
            else
            {
                db.collection(email!).document(username + " ID: " + uid).collection(email!).document().updateData(<#T##fields: [AnyHashable : Any]##[AnyHashable : Any]#>, completion: <#T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void#>)
            }
            
            
            */
            
            /*
            db.collection("Java").getDocuments { (snapshot, error) in
                if error == nil  && snapshot != nil
                {
                    guard let snap = snapshot else {return}
                    
                    for documents in snap.documents
                    {
                        let data = documents.data();
                        let errors = data["Error"] as? String ?? "Nothing in database";
                        let solution = data["Solution"] as? String ?? "Nothing in database";
                        let newData = Whole(Error: errors, Solution: solution);
                        self.errorAndsolution.append(newData);
                    }
                    print(self.errorAndsolution);
                    self.table_view.reloadData()
                }
            }
     
            */
            
            /*
            db.collection("Java").getDocuments { [self] (snapshot, error) in
                if error == nil && snapshot != nil
                
                {
                    for documents in snapshot!.documents
                    {
                        let documentData = documents.data()
                        let error = documentData["Error"] as? String;
                        //let solution = documentData["Solution"] as? String;
                        let new = Whole(Error: error!);
                        errorAndsolution.append(new);
                        print(errorAndsolution);
                        
                        
                        
                    }
                    //table.reloadData();
                }
            }
     */
            
            
            
            
            
            
            
            
            
            
            DispatchQueue.main.async {
                self.table_view.reloadData()
            }
            
            table_view.reloadData()
        }
        
        
       

        // Do any additional setup after loading the view.
    }
 
  
    
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return errorAndsolution.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        
        let data = errorAndsolution[indexPath.row];
        
        cell.error_label.text = data.Error;
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("Row selected \(indexPath.row) ")

    }
    
    
    */
    
    
    
    
    
    
    

}

//MARK: - TableView
extension HomeViewController: UITableViewDelegate,UITableViewDataSource
{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("E: \(errorAndsolution.count)")
        
        if !filterDataES.isEmpty
        {
            return filterDataES.count
        }
        else
        {
            return errorAndsolution.count;
        }
        
        
        
        
        
        
        
        
        
        
    }
    
    //MARK: - Cell Data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell
        let email = UserDefaults.standard.string(forKey: "email")
        //let Husername = UserDefaults.standard.string(forKey: "username") ?? "Guest"
        //let Hprofession = UserDefaults.standard.string(forKey: "profession") ?? "p"
        //let userID = UserDefaults.standard.string(forKey: "userId") ?? "12345"

        
        
        //MARK:- Search Result
        if (!filterDataES.isEmpty)
        {
            searchController.searchBar.searchTextField.text = searchBarText
            let data = filterDataES[indexPath.row]
            
            //let likes = homeLikes[indexPath.row]
            /*
            let url_ = URL(string: data.ImageUrl)
            
            let task = URLSession.shared.dataTask(with: url_!, completionHandler: {data, _, error in
                if(error == nil && data != nil)
                {
                    DispatchQueue.main.async{
                        let image = UIImage(data: data!)
                        cell?.image_label.image = image
                    }
                   
                }
            })
            task.resume()
            */
            
            cell?.e_label.text = "Error: \(data.Error)";
            
            cell?.username_label.text = "Username: \(data.Username)"
            
            cell?.profession_label.text = "Profession: \(data.Profession)"
            
            cell?.s_label.text = "Language: \(data.Language)";
            
            cell?.posted_on.text = "Posted on: \(data.PostedOn)"
            
            //Main Home Image Settings
            /*
            db.collection(email!).document(data.Username + " ID: " + data.UserID).getDocument { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    let pimg_ = snapshot?.get("ImageUrl");
                    self.db.collection(email!).document(data.Language + " ID: " + data.Id).setData(["ProfileHomeImg":pimg_!]);
                    
                    //Downloading image and setting it
                   
                    print("imageurl: \(pimg_ ?? "No Value")")
                    let url_ = URL(string: pimg_ as! String)!
                    
                    let task = URLSession.shared.dataTask(with: url_, completionHandler: {data, _, error in
                        
                        guard let data = data, error == nil else{
                            return
                        }
                        DispatchQueue.main.async{
                            let image = UIImage(data: data)
                            cell?.homeImg.image = image
                        }
                    })
                    task.resume()
                }
                else
                {
                    print("Error Occured");
                }
            }
            */
            
            /*
            if(likes.HLikes == 0)
            {
                cell?.H_like_btn_tapped.setImage(UIImage(named: "heart_outline")?.withTintColor(.black), for: .normal)
            }
            else
            {
                cell?.H_like_btn_tapped.setImage(UIImage(named: "heart_fill")?.withTintColor(.red), for: .normal)
            }
            
            cell?.H_like_label.text = String(likes.HLikes)
            */
            
            // for getting summation of likes
            let email = UserDefaults.standard.string(forKey: "email")
            db.collection(email!).document(data.Language + " ID: " + data.Id).collection("Solution").whereField("Type", isEqualTo: "Solution").getDocuments { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    var sum = 0
                    for documents in snapshot!.documents
                    {
                        let data = documents.data()
                        let Likes = data["Likes"] as? Int ?? 0
                        sum = sum + Likes
                        
                        
                    }
                    let t_sum = sum
                    let newsum = OnlyLikes(HLikes: sum)
                    self.filterHomeLikes.append(newsum)
                    
                    self.db.collection(email!).document(data.Language + " ID: " + data.Id).updateData(["HomeLikes":t_sum])
                    
                    if(t_sum == 0)
                    {
                        cell?.H_like_btn_tapped.setImage(UIImage(named: "heart_outline"), for: .normal)

                    }
                    else
                    {
                        cell?.H_like_btn_tapped.setImage(UIImage(named: "heart_fill")?.withTintColor(.red), for: .normal)

                    }
                    cell?.H_like_label.text = String(t_sum)
                    //print(self.homeLikes)
                   
                }
                
            }
            //cell?.H_like_label.text = String(t_sum)
        }
        
        
        
        //MARK:- Normal Result
        else
        {
            searchController.searchBar.searchTextField.text = searchBarText
            let data = errorAndsolution[indexPath.row]
            
            //let likes = homeLikes[indexPath.row]
            /*
            print("imageurl: \(data.ImageUrl)")
            let url_ = URL(string: data.ImageUrl)!
            
            let task = URLSession.shared.dataTask(with: url_, completionHandler: {data, _, error in
                
                guard let data = data, error == nil else{
                    return
                }
                DispatchQueue.main.async{
                    let image = UIImage(data: data)
                    cell?.image_label.image = image
                }
            })
            task.resume()
            */
            
            cell?.e_label.text = "Error: \(data.Error)";
            
            cell?.username_label.text = "Username: \(data.Username)"
            
            cell?.profession_label.text = "Profession: \(data.Profession)"
            
            cell?.s_label.text = "Language: \(data.Language)";
            
            cell?.posted_on.text = "Posted on: \(data.PostedOn)"
            
            //imguplload\
            
            //MARK:-Main Image Settings
            /*
            db.collection(email!).document(data.Username + " ID: " + data.UserID).getDocument { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    let pimg_ = snapshot?.get("ImageUrl")as? String ?? "No values" ;
                    self.db.collection(email!).document(data.Language + " ID: " + data.Id).updateData(["ProfileHomeImg":pimg_]);
                    
                    //Downloading image and setting it
                   
                    print("imageurl: \(pimg_ )")
                    let url_ = URL(string: pimg_ )!
                    
                    let task = URLSession.shared.dataTask(with: url_, completionHandler: {data, _, error in
                        
                        guard let data = data, error == nil else{
                            return
                        }
                        DispatchQueue.main.async{
                            let image = UIImage(data: data)
                            cell?.homeImg.image = image
                        }
                    })
                    task.resume()
                }
                else
                {
                    print("Error Occured");
                }
            }
            */
            
            /*
            if(likes.HLikes == 0)
            {
                cell?.H_like_btn_tapped.setImage(UIImage(named: "heart_outline")?.withTintColor(.black), for: .normal)
            }
            else
            {
                cell?.H_like_btn_tapped.setImage(UIImage(named: "heart_fill")?.withTintColor(.red), for: .normal)
            }
            
            cell?.H_like_label.text = String(likes.HLikes)
            */
            
            // for getting summation of likes
            let email = UserDefaults.standard.string(forKey: "email")
            db.collection(email!).document(data.Language + " ID: " + data.Id).collection("Solution").whereField("Type", isEqualTo: "Solution").getDocuments { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    var sum = 0
                    for documents in snapshot!.documents
                    {
                        let data = documents.data()
                        let Likes = data["Likes"] as? Int ?? 0
                        sum = sum + Likes
                        
                        
                    }
                    let t_sum = sum
                    let newsum = OnlyLikes(HLikes: sum)
                    self.homeLikes.append(newsum)
                    
                    self.db.collection(email!).document(data.Language + " ID: " + data.Id).updateData(["HomeLikes":t_sum])
                    
                    if(t_sum == 0)
                    {
                        cell?.H_like_btn_tapped.setImage(UIImage(named: "heart_outline"), for: .normal)

                    }
                    else
                    {
                        cell?.H_like_btn_tapped.setImage(UIImage(named: "heart_fill")?.withTintColor(.red), for: .normal)

                    }
                    cell?.H_like_label.text = String(t_sum)
                    //print(self.homeLikes)
                   
                }
                
            }
            //cell?.H_like_label.text = String(t_sum)
            
        }
       
       
        
        
        
        
        
        return cell!;
    }
    
    //MARK: - On Row Select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.row)")
        
        
       
       
        
        
        if(!filterDataES.isEmpty)
        {
            searchController.searchBar.searchTextField.text = searchBarText
            let data = filterDataES[indexPath.row]
            UserDefaults.standard.setValue(data.Error, forKey: "error")
            UserDefaults.standard.setValue(data.Id, forKey: "id")
            UserDefaults.standard.setValue(data.Language, forKey: "language")
            UserDefaults.standard.setValue(data.Error, forKey: "ErrorForSU")
            performSegue(withIdentifier: "HtoSolutionSeg", sender: self)
        }
        else
        {
            searchController.searchBar.searchTextField.text = searchBarText
            let data = errorAndsolution[indexPath.row]
            UserDefaults.standard.setValue(data.Error, forKey: "error")
            UserDefaults.standard.setValue(data.Id, forKey: "id")
            UserDefaults.standard.setValue(data.Language, forKey: "language")
            UserDefaults.standard.setValue(data.Error, forKey: "ErrorForSU")
            performSegue(withIdentifier: "HtoSolutionSeg", sender: self)
        }
        
        
        
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell
        
        if(cell?.like_flag == 0)
        {
            cell?.like_btn_action(self)
        }
        else
        {
            cell?.like_btn_action(self)
        }
         */
        
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "HtoSolutionSeg")
        {
            let random = segue.destination as! SolutionViewController
            random.ID =
            random.langName = data.Language
           
        }
        
    }
     */
    /*
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, estimatedHeightForRowAt: indexPath)
    }
     */
}

//MARK:- Tabbar
extension HomeViewController: UITabBarDelegate, UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if(tabBarIndex == 0)
        {
            print("Home called")
            //table_view.reloadData()
            //view.reloadInputViews()
            table_view.reloadData()
            viewDidLoad()
            //table_view.reloadData()
        }
        
        if(tabBarIndex == 1)
        {
            print("Home Notification called")
            //NotificationCenter.default.post(name: Notification.Name(rawValue: "ReloadPage"), object: nil)
            table_view.reloadData()
            viewDidLoad()
        }
        if(tabBarIndex == 2)
        {
            print("Home Profile called")
            table_view.reloadData()
            viewDidLoad()
        }
         
    }
    
    
}

