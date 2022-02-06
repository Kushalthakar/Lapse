//
//  SortViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 29/06/21.
//

import UIKit
import Firebase

//MARK:- SortViewController
class SortViewController: UIViewController {

    var db = Firestore.firestore()
    
    var instanceOfSolution = SolutionViewController()
    
    
    @IBOutlet weak var like_btn_label: UIButton!
    
    @IBOutlet weak var latest_btn_label: UIButton!
    
    
    
    @IBAction func like_btn(_ sender: Any)
    {
        
        
        
        //print("Like btn pressed")
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "sortByLikes"), object: nil)
        
        //let storyboard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        //let vc:SolutionTableViewController = storyboard.instantiateViewController(withIdentifier: "SolutionTableViewController") as! SolutionTableViewController
        
        //vc.sortflag = 1
        
        //performSegue(withIdentifier: "xyz", sender: self)
        
        //vc.sortLikes()
        
        //let sol:SolutionViewController = self.storyboard?.instantiateViewController(identifier: "sol") as! SolutionViewController
        
        //navigationController?.pushViewController(sol, animated: true)
        
        let email = UserDefaults.standard.string(forKey: "email")
        let username = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        
        self.db.collection(email!).document(username! + " ID: " + userID!).updateData(["Sort":1])
        
        //vc.tableView.reloadData()
        //vc.table_view.reloadData()
        //vc.viewDidLoad()
        
        
        
    }
    
    //MARK:- Sort
    @IBAction func latest_btn(_ sender: Any)
    {
        //let storyboard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        //let vc:SolutionTableViewController = storyboard.instantiateViewController(withIdentifier: "SolutionTableViewController") as! SolutionTableViewController
        
        //print("Latest btn pressed")
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "sortByLatest"), object: nil)
        let email = UserDefaults.standard.string(forKey: "email")
        let username = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        self.db.collection(email!).document(username! + " ID: " + userID!).updateData(["Sort":0])
        
        //vc.tableView.reloadData()
        //vc.table_view.reloadData()
        //vc.viewDidLoad()
    }
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        like_btn_label.layer.cornerRadius = 20;
        like_btn_label.layer.borderWidth = 1;
        like_btn_label.clipsToBounds = true;
        
        
        
        latest_btn_label.layer.cornerRadius = 20;
        latest_btn_label.layer.borderWidth = 1;
        like_btn_label.clipsToBounds = true;
        
        
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
