//
//  UpdateSolutionPopUpViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 16/07/21.
//

import UIKit
import Firebase

//MARK:- UpdateSolutionPopViewController
class UpdateSolutionPopUpViewController: UIViewController {

    @IBOutlet weak var view_design: UIView!
    
    @IBOutlet weak var tv_design: UITextView!
    
    var db = Firestore.firestore()
    
    
    @IBAction func update_btn(_ sender: Any)
    {
        let email = UserDefaults.standard.string(forKey: "email")
        let u_sername = UserDefaults.standard.string(forKey: "username")
        let userID = UserDefaults.standard.string(forKey: "userId")
        let ID = UserDefaults.standard.string(forKey: "id")!;
        let langName = UserDefaults.standard.string(forKey: "language")!
        //let historysolution = UserDefaults.standard.string(forKey: "HistorySolution")!
        let historysolutionid = UserDefaults.standard.string(forKey: "HistorySolutionId")!
        
        
        db.collection(email!).document(langName + " ID: " + ID).updateData(["Solution":tv_design.text ?? "No solution"])
        
        db.collection(email!).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + historysolutionid).updateData(["SolutionA":tv_design.text ?? "No solution"])
        
        db.collection(email!).document(u_sername! + " ID: " + userID!).collection("USolution").document("Solution ID: " + historysolutionid).updateData(["SolutionA":tv_design.text ?? "No solution"])
        
        db.collection(email!).document(u_sername! + " ID: " + userID!).collection("Save").document("SaveID: " + ID).updateData(["SUSolution":tv_design.text ?? "No Solution"])
        
        /*
        db.collection(email!).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + historysolutionid!).updateData(["SolutionA":tv_design.text])
        
        db.collection(email!).document(u_sername! + " ID: " + userID!).collection("USolution").document("Solution ID: " + )
       */
    }
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        tv_design.layer.cornerRadius = 10
        tv_design.clipsToBounds = true
        view_design.layer.cornerRadius = 10
        view_design.layer.shadowOffset = CGSize(width: 5, height: 5)
        view_design.layer.shadowRadius = 10
        view_design.layer.shadowOpacity = 0.3
        
        
        
        
        let historysolution = UserDefaults.standard.string(forKey: "HistorySolution")
        print("History \(historysolution)")
        
        tv_design.text = historysolution
        
        
        //db.collection(email!).document(langName)
        
        /*
         db.collection(email!).document(lang_name + " ID: " + random).setData(["Type":e, "Language": lang_name, "ID": random,"Error":error_txt, "Solution":ans_txt, "Username":username!, "Profession":profession!, "Likes":likes, "Status":false, "DateTime":dateTime, "Date":Date, "Time":Time, "UserID":uid!])
         
         db.collection(email!).document(lang_name + " ID: " + random).collection("Solution").document("Solution ID: " + random).setData(["Type":"Solution", "SolutionA":ans_txt, "ID":random, "Likes":likes, "Status":false,"Username":username!, "Profession":profession!, "DateTime":dateTime, "Date":Date, "Time":Time, "SError":error_txt, "Reason":reason1, "UserID":uid!])
         
         db.collection(email!).document(username! + " ID: " + uid!).collection("USolution").document("Solution ID: " + random).setData(["Type":"Solution", "SolutionA":ans_txt, "ID":random, "Likes":likes, "Status":false,"Username":username!, "Profession":profession!, "DateTime":dateTime, "Date":Date, "Time":Time, "USError":error_txt, "Reason":reason1])
         
         
         //Home DB
         db.collection(email!).document(langName + " ID: " + ID).collection("Solution").document("Solution ID: " + random).setData(["ID":random,"Type":"Solution", "SolutionA":s_txt!, "Likes":likes, "Status":false, "Username":username!, "Profession":profession!, "DateTime":dateTime, "Date":Date, "Time":Time, "SError":errorSU!, "Reason":reason2, "SaveFlag":false, "UserID":userID!])
         
         
         //user history
         db.collection(email!).document(username! + " ID: " + userID!).collection("USolution").document("Solution ID: " + random).setData(["ID":random,"Type":"Solution", "SolutionA":s_txt!, "Likes":likes, "Status":false, "Username":username!, "Profession":profession!, "DateTime":dateTime, "Date":Date, "Time":Time, "USError":errorSU!, "Reason":reason2, "SaveFlag":false])
         
         */
        
        
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
