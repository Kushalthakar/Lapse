//
//  SolutionViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 24/06/21.
//
//done adding solution to table
//done like for solutions
//
//
import UIKit
import Firebase

//struct SolutionWhole {
   // var Solution, Id : String
    //var Likes: Int
    //var Status:Bool
//}


class SolutionViewController: UIViewController, UISearchBarDelegate {
    /*
    let refreshControl = UIRefreshControl()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var like_flag = 0;
    
    var lik_count = 0;
    
    var solId = "";
    
    var db = Firestore.firestore()
    
    var structSolution = [SolutionWhole]();
    
    var filterstructSolution = [SolutionWhole]();
    
    //var lang_id = ""
    //var indexpath = IndexPath
    var ID = "";
    var langName = "";
    var error = "";
    
    @IBOutlet weak var error_view_display: UIView!
    
    
    
    @IBOutlet weak var table_view: UITableView!
    
    
    @IBOutlet weak var s_error_disp: UILabel!
    
    @IBAction func solution_add(_ sender: Any)
    {
        performSegue(withIdentifier: "SolutionToAddSolutionSeg", sender: self)
    }
    
    @objc func back(sender: UINavigationItem)
    {
        self.performSegue(withIdentifier: "backHomeSegfromS", sender: self)
    }
    
    
    
    @IBAction func s_like_tapped(_ sender: Any)
    {
        if(like_flag == 0)
        {
            //s_like_label.setImage(UIImage(named: "heart_fill")?.withTintColor(.red),  for: .normal )
            //updateLikes()
            
            //like_flag = 1
            //lik_count = lik_count + 1;
            //s_like_count.text = String(lik_count)
            
        }
        else
        {
            //s_like_label.setImage(UIImage(named: "heart_outline"), for: .normal )
            //updateLikes()
            
            //like_flag = 0
            //lik_count = lik_count - 1
            //s_like_count.text = String(lik_count)
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        viewDidLoad()
        //table_view.reloadData()
        refreshControl.endRefreshing()
    }
    
    //@objc func disconnectPaxiSocket(_ notification: Notification) {
        print("Printing on Double Tapped")
    
        //viewDidLoad()
        //table_view.clearsContextBeforeDrawing = true
        
        //table_view.reloadData()
        //let indexPath = IndexPath(row: 0, section: 0)
        //tableView(table_view, cellForRowAt: indexPath)
        //table_view.reloadRows(at: [indexPath], with: .fade)
        
    }
     
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
     
     /*
    @objc func reTapped(_ notification: Notification) {
        print("Printing on Double Tapped")
        
        viewDidLoad()
       
        
    }
     
    */
    
    @objc func doubleTapped()
    {
        
        //displayLikes()
        print("Double Tapped from Main")
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
    }
    
    @objc func sortByLikes(_ notification: Notification)
    {
        print("Like called from sort to solution viewController")
    }
    
    @objc func sortByLatest(_ notification: Notification)
    {
        print("Latest called from sort to solution viewController")
    }
    
    func sortLikes()
    {
        print("Called Sort Likes")
    }
    func sortLatest()
    {
        print("Called Sort Latest")
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        filterstructSolution = [];
        print(searchText)
        if(searchText == "")
        {
            filterstructSolution = structSolution
            self.table_view.reloadData()
        }
        else
        {
            for filterData in structSolution
            {
               
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        structSolution = [];
        
        filterstructSolution = structSolution
        table_view.clearsContextBeforeDrawing = false
        
        error_view_display.layer.cornerRadius = 10
        error_view_display.layer.borderWidth = 1;
        error_view_display.clipsToBounds = true;
        
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        
        
        
        //NotificationCenter.default.addObserver(self, selector: #selector(disconnectPaxiSocket(_:)), name: Notification.(rawValue: "disconnectPaxiSockets"), object: nil)
        
        //NotificationCenter.default.addObserver(self, selector: #selector(sortByLikes(_:)), name: Notification.Name(rawValue: "sortByLikes"), object: nil)
        
       // NotificationCenter.default.addObserver(self, selector: #selector(sortByLatest(_:)), name: Notification.Name(rawValue: "sortByLatest"), object: nil)
        
        
        //NotificationCenter.default.addObserver(self, selector: #selector(reTapped(_:)), name: Notification.Name(rawValue: "reTapped"), object: nil)
        
        //print("Printing on Double Tap")
        
        
        
        self.navigationItem.hidesBackButton = true
        
        //self.tabBarController?.hidesBottomBarWhenPushed = true
        
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        table_view.addSubview(refreshControl)
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2;
        table_view.addGestureRecognizer(tap)
        
    
        //let newBackBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(AddViewController.back(sender:)))
        //self.navigationItem.leftBarButtonItem = newBackBtn
        //newBackBtn.tintColor = .black
        
        
        let email = UserDefaults.standard.string(forKey: "email")
        
        error = UserDefaults.standard.string(forKey: "error")!
        s_error_disp.text = "Error: " + error

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
        
        
        
        DispatchQueue.main.async {
            self.table_view.reloadData()
        }
        
        table_view.reloadData()
        
        ID = UserDefaults.standard.string(forKey: "id")!;
        langName = UserDefaults.standard.string(forKey: "language")!
        
        
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
                    let likes = data["Likes"] as? Int ?? 0
                    let status = data["Status"] as? Bool ?? false
                    let newData = SolutionWhole(Solution: solution, Id: id, Likes: likes, Status: status);
                    self.structSolution.append(newData);
                    
                }
                //print(self.structSolution)
                self.structSolution.sort { $0.Likes > $1.Likes }
                print(self.structSolution)
                self.table_view.reloadData()
                //print(self.structSolution.count)
            }
            else
            {
                print("Error occured")
            }
        }
        
        
    }
    
   
    func updateLikes()
    {
        
    }
  
}
*/

/*
extension SolutionViewController: UITableViewDelegate, UITableViewDataSource
{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
        
        if(!filterstructSolution.isEmpty)
        {
            let data = filterstructSolution[indexPath.row]
            print("Selected \(indexPath.row)")
            
            UserDefaults.standard.setValue(data.Id, forKey: "sid")
            print(data.Id)
        }
        else
        {
            let data = structSolution[indexPath.row]
            
            print("Selected \(indexPath.row)")
            
            UserDefaults.standard.setValue(data.Id, forKey: "sid")
            print(data.Id)
        }
        
        
       
        //tableView.reloadData()
        
        //UserDefaults.standard.setValue(data.Likes, forKey: "likes")
        //UserDefaults.standard.setValue(data.Status, forKey: "status")
       
        
        //SolutionTableViewCell.awakeFromNib()
                
       
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(structSolution.count)
        
        if(!filterstructSolution.isEmpty)
        {
            print(structSolution.count)
            return structSolution.count;
        }
        else
        {
            print(structSolution.count)
            return structSolution.count;
        }
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SolutionTableViewCell
        
        
        
        if(!filterstructSolution.isEmpty)
        {
            let data = filterstructSolution[indexPath.row]
            
            cell.solution_label.text = data.Solution;
            
            if(data.Likes >= 0 && data.Status == true)
            {
                cell.get_like_db = data.Likes
                cell.like_flag = 1
                
                cell.s_like_tapped.setImage(UIImage(named: "heart_fill")?.withTintColor(.red),  for: .normal )
                cell.s_like_label.text = String(data.Likes)
                
                
            }
            
            else if(data.Likes >= 0 && data.Status == false)
            {
               
                cell.s_like_tapped.setImage(UIImage(named: "heart_outline"), for: .normal )
                cell.get_like_db = data.Likes
                
                cell.s_like_label.text = String(data.Likes)
                cell.like_flag = 0
                
            }
            //cell.s_like_tapped.setImage(UIImage(named: "heart_fill")?.withTintColor(.red), for: .normal )
            
            //cell.s_like_label.text = "20"
            
        
        }
        else
        {
            let data = structSolution[indexPath.row]
            
            cell.solution_label.text = data.Solution;
            
            if(data.Likes >= 0 && data.Status == true)
            {
                cell.get_like_db = data.Likes
                cell.like_flag = 1
                
                cell.s_like_tapped.setImage(UIImage(named: "heart_fill")?.withTintColor(.red),  for: .normal )
                cell.s_like_label.text = String(data.Likes)
                
                
            }
            
            else if(data.Likes >= 0 && data.Status == false)
            {
               
                cell.s_like_tapped.setImage(UIImage(named: "heart_outline"), for: .normal )
                cell.get_like_db = data.Likes
                
                cell.s_like_label.text = String(data.Likes)
                cell.like_flag = 0
                
            }
            //cell.s_like_tapped.setImage(UIImage(named: "heart_fill")?.withTintColor(.red), for: .normal )
            
            //cell.s_like_label.text = "20"
        }
        
        
        return cell;
    }
    
    

}
*/
}
