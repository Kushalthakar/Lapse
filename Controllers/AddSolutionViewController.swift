//
//  AddSolutionViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 24/06/21.
//

import UIKit
import Firebase

//MARK:- AddSolutionViewController
class AddSolutionViewController: UIViewController {
    
    var db = Firestore.firestore();
    
    var ID = "";
    var langName = "";
    
    
  
    @IBOutlet weak var solution_txt: UITextView!
    
    @IBOutlet weak var save_btn_label: UIButton!
    
    //MARK:- Save btn
    @IBAction func s_save_btn(_ sender: Any)
    {
        let likes = 0;
        //let status = false;
        
        let date = Date()
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        timeFormatter.dateFormat = "HH:mm:ss"
        let Date = dateFormatter.string(from: date)
        let Time = timeFormatter.string(from: date)
        let dateTime = Date + " " + Time
        
        
        
        let email = UserDefaults.standard.string(forKey: "email");
        
        let username = UserDefaults.standard.string(forKey: "username")
        
        let profession = UserDefaults.standard.string(forKey: "profession")
        
        let userID = UserDefaults.standard.string(forKey: "userId")
        
        let errorSU = UserDefaults.standard.string(forKey: "ErrorForSU")
        
        let s_txt = solution_txt.text
    
        
        let random = String(Int.random(in: 0..<999999))
        
        let reason2 = "You added solution to above error"
        
        ID = UserDefaults.standard.string(forKey: "id")!;
        langName = UserDefaults.standard.string(forKey: "language")!
        
        //Home DB
        db.collection(email!).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + random).setData(["ID":random,"Type":"Solution", "SolutionA":s_txt!, "Likes":likes, "Status":false, "Username":username!, "Profession":profession!, "DateTime":dateTime, "Date":Date, "Time":Time, "SError":errorSU!, "Reason":reason2, "SaveFlag":false, "UserID":userID!, "ProfileHomeImg":"NoImg"])
        
        
        //user history
        db.collection(email!).document(username! + " ID: " + userID!).collection("USolution").document("Solution ID: " + random).setData(["ID":random,"Type":"Solution", "SolutionA":s_txt!, "Likes":likes, "Status":false, "Username":username!, "Profession":profession!, "DateTime":dateTime, "Date":Date, "Time":Time, "USError":errorSU!, "Reason":reason2, "SaveFlag":false, "ImageUrl":"NoImg"])
        
        //
        db.collection(email!).document(username! + " ID: " + userID!).collection(email!).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + random).setData(["ID":random,"Type":"Solution", "SolutionA":s_txt!, "Likes":likes, "Status":false, "Username":username!, "Profession":profession!, "DateTime":dateTime, "Date":Date, "Time":Time, "SError":errorSU!, "Reason":reason2, "SaveFlag":false,"ImageUrl":"NoImg"])
        
        performSegue(withIdentifier: "addStoSSeg", sender: self)
    }
    
    
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        save_btn_label.layer.cornerRadius = 10;
        solution_txt.layer.cornerRadius = 20;
        solution_txt.layer.borderWidth = 1;
        solution_txt.clipsToBounds = true;
        // Do any additional setup after loading the view.
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
