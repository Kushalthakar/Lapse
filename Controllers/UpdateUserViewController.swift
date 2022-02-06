//
//  UpdateUserViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 28/06/21.
//

import UIKit
import Firebase

struct Uname {
    var Username:String
}

struct UserData {
    var UserName_, Profession_ , Id_ : String
}
//MARK: - UpdateUserViewController
class UpdateUserViewController: UIViewController {
    
    var db = Firestore.firestore();
    
    var username = "";
    
    var structUsername = [Uname]();
    
    var structUserData = [UserData]();
    
    var profession = "";
    
    var save_flag = 0;
    
    //var count = 0;
    
    @IBOutlet weak var username_txt: UITextField!
    
    @IBOutlet weak var profession_txt: UITextField!
    
    @IBOutlet weak var save_btn_label: UIButton!
    
    
    @IBOutlet weak var recovery_txt: UITextField!
    
    @IBOutlet weak var recovery_btn_lable: UIButton!
    
    //MARK: - Recovery Btn
    @IBAction func recovery_btn(_ sender: Any)
    {
        //fetching user
        let email = UserDefaults.standard.string(forKey: "email")
        db.collection(email!).whereField("User", isEqualTo: "User").getDocuments { (snapshot, error) in
            if(error == nil && snapshot != nil)
            {
                for documents in snapshot!.documents
                {
                    let data = documents.data()
                    let uname = data["Username"] as? String ?? "No user found"
                    let prof = data["Profession"] as? String ?? "No profession"
                    let id_ = data["ID"] as? String ?? "no id"
                    
                    let ndata = UserData(UserName_: uname, Profession_: prof, Id_: id_)
                    self.structUserData.append(ndata)
                }
                
                for ud in self.structUserData
                {
                    if(self.recovery_txt.text == ud.Id_)
                    {
                        self.username_txt.text = ud.UserName_
                        self.profession_txt.text = ud.Profession_
                        self.recovery_txt.text = ud.Id_
                        
                        UserDefaults.standard.setValue(self.username_txt.text, forKey: "username")
                        UserDefaults.standard.setValue(self.profession_txt.text, forKey: "profession")
                        UserDefaults.standard.setValue(self.recovery_txt.text, forKey: "userId" )
                        
                        self.username_txt.isEnabled = false
                        self.profession_txt.isEnabled = false
                        self.recovery_txt.isEnabled = false
                        self.save_btn_label.isEnabled = false
                        self.recovery_btn_lable.isEnabled = false
                        
                    }
                }
            }
            
        }
        
        
        
    }
    
    
    //MARK: - Save Btn
    @IBAction func save_btn(_ sender: Any)
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        timeFormatter.dateFormat = "HH:mm:ss"
        let Date = dateFormatter.string(from: date)
        let Time = timeFormatter.string(from: date)
        let dateTime = Date + " " + Time
        
        if (username_txt.text != nil && profession_txt.text != nil && username_txt.isEnabled == false && profession_txt.isEnabled == false && save_flag == 1)
        {
            print("Can't be edited")
            recovery_btn_lable.isHidden = true
        }
        else
        {
            let email = UserDefaults.standard.string(forKey: "email")
            
            db.collection(email!).whereField("User", isEqualTo: "User").getDocuments { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    for documents in snapshot!.documents
                    {
                        let data = documents.data()
                        
                        let userName = data["Username"] as? String ?? "No User"
                        print(userName)
                        let newUser = Uname(Username: userName)
                        self.structUsername.append(newUser);
                        
                    }
                    
                    
                    
                    
                    print(self.structUsername)
                    var c = 0
                    for use in self.structUsername
                    {
                        if(self.username_txt.text == use.Username)
                        {
                            c = 1
                            print(use.Username)
                            print("Data already exist")
                        }
                    }
                    if(c == 0)
                    {
                        self.username = self.username_txt.text!
                        self.profession = self.profession_txt.text!
                            
                        UserDefaults.standard.setValue(self.username, forKey: "username")
                        UserDefaults.standard.setValue(self.profession, forKey: "profession")
                        //UserDefaults.standard.synchronize()
                            
                        let id = String(Int.random(in: 0..<999999))
                        
                        UserDefaults.standard.setValue(id, forKey: "userId")
                        
                       
                       
                        self.db.collection(email!).document(email!).getDocument { (snapshot, error) in
                            if(error == nil && snapshot != nil)
                            {
                                let Dcount_ = snapshot!.get("Count") as? Int ?? 0
                                let Ucount_ = snapshot!.get("UserCount") as? Int ?? 0
                                print("DCount_: \(Dcount_)")
                                //var count = Dcount_ + 1
                                print("UCount: \(Ucount_)")
                                if(Ucount_ >= Dcount_)
                                {
                                    //self.db.collection(email!).document(email!).updateData(["Count":count])
                                    
                                    let alert = UIAlertController(title:"Company Limit reached" , message: "Can't proceeed", preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Okay", style:.default , handler: { action in
                                        
                                        //new
                                        if (Auth.auth().currentUser != nil)
                                        {
                                            UserDefaults.standard.setValue("Guest", forKey: "username")
                                            UserDefaults.standard.setValue("p", forKey: "profession")
                                            UserDefaults.standard.setValue("12345", forKey: "userId" )
                                            
                                            do
                                            {
                                                try Auth.auth().signOut()
                                                //self.tabBarController?.viewWillDisappear(true)
                                                //count = count - 1
                                                //self.db.collection(email!).document(email!).updateData(["Count":count])
                                                
                                                UserDefaults.standard.setValue("", forKey: "email")
                                                self.performSegue(withIdentifier: "utolseg", sender: self)
                                                
                                                
                                                
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
                                        else
                                        {
                                            print("Not Auth")
                                        }
                                        
                                        
                                        
                                        //old
                                        /*
                                        do
                                        {
                                            try Auth.auth().signOut()
                                            count = count - 1
                                            self.db.collection(email!).document(email!).updateData(["Count":count])
                                            self.username = ""
                                            self.profession = ""
                                            //self.tabBarController?.viewWillDisappear(true)
                                            UserDefaults.standard.setValue("", forKey: "email")
                                            self.performSegue(withIdentifier: "utolseg", sender: self)
                                            
                                            
                                            
                                            //let ss = storyboard?.instantiateViewController(identifier: "loginVC")
                                            //storyboard?.instantiateViewController(identifier: loginVC) as? LoginPageViewController
                                            //view.window?.rootViewController = ss;
                                            //view.window?.makeKeyAndVisible()
                                            
                                        }
                                        catch
                                        {
                                            print("Exception")
                                        }
                                        
                                        */
                                    }))
                                    
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                                else
                                {
                                    var ucount = 0
                                    self.db.collection(email!).document(self.username + " ID: " + id).setData(["ID":id, "Username":self.username, "Profession":self.profession, "User":"User", "Sort":1, "HomeSort":1, "DateTime":dateTime, "Date":Date, "Time":Time, "DateFlag":false, "HomeDateFlag":false, "HistorySortFlag":false, "SaveSortFlag":false,"Aggrement":true, "ImageUrl":"NoImg"])
                                    self.db.collection(email!).whereField("User", isEqualTo: "User").getDocuments { (snapshot, error) in
                                        if(error == nil && snapshot != nil)
                                        {
                                            for _ in snapshot!.documents
                                            {
                                                ucount = ucount + 1
                                            }
                                            self.db.collection(email!).document(email!).updateData(["UserCount":ucount])
                                        }
                                        else
                                        {
                                            print("Error occured")
                                        }
                                    }
                                    //self.db.collection(email!).document(email!).updateData(["UserCount":])
                                    
                                    self.recovery_txt.text = id
                                    self.recovery_btn_lable.isHidden = true
                                    
                                    self.username_txt.text = self.username
                                    self.profession_txt.text = self.profession
                                    self.username_txt.isEnabled = false
                                    self.profession_txt.isEnabled = false
                                    self.save_btn_label.isEnabled = false
                                    self.save_btn_label.isHidden = true
                                    
                                    self.save_flag = 1;
                                }
                                
                            }
                            else
                            {
                                print("Error occured")
                            }
                        }
                        
                        
                        
                        
                        
                        
                       
                    }
                    else
                    {
                        print("can't save")
                    }
                    
                    
                    
                    
                    
                    
                }
                else
                {
                    print("Error occured")
                }
            }
           
            
            
            
            
            
            
            
            
            
            
        }
        
        
        
    }
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //let email = UserDefaults.standard.string(forKey: "email")
        self.navigationItem.hidesBackButton = true
        
        let u = UserDefaults.standard.string(forKey: "username")
        let p = UserDefaults.standard.string(forKey: "profession")
        let i = UserDefaults.standard.string(forKey: "userId")
        
        if(u == "Guest" && p == "p" && i == "12345")
        {
            username_txt.text = ""
            profession_txt.text = ""
            recovery_txt.text = ""
        }
        else
        {
            username_txt.text = u
            profession_txt.text = p
        }
        
        
        //print(u!)
        //print(p!)
        
        //db.collection(email!).document()
        print("SaveFlag: \(save_flag)")
        if(username_txt.text != "" && profession_txt.text != "")
        {
            
            print("Can't be edited")
            username_txt.isEnabled = false
            profession_txt.isEnabled = false
            save_btn_label.isHidden = true
            
            recovery_txt.text = i
            recovery_txt.isEnabled = false
            recovery_btn_lable.isHidden = true
        }
        else
        {
            recovery_btn_lable.isHidden = false
        }
        
        
        username_txt.layer.cornerRadius = 10;
        username_txt.layer.borderWidth = 1;
        username_txt.clipsToBounds = true
        
        profession_txt.layer.cornerRadius = 10;
        profession_txt.layer.borderWidth = 1;
        profession_txt.clipsToBounds = true
        
        save_btn_label.layer.cornerRadius = 10;
        save_btn_label.layer.borderWidth = 1;
        save_btn_label.clipsToBounds = true
        
        recovery_txt.layer.cornerRadius = 10;
        recovery_txt.layer.borderWidth = 1;
        recovery_txt.clipsToBounds = true
        
        recovery_btn_lable.layer.cornerRadius = 10;
        recovery_btn_lable.layer.borderWidth = 1;
        recovery_btn_lable.clipsToBounds = true
        
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
