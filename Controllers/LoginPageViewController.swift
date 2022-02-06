//
//  LoginPageViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 21/06/21.
//

import UIKit
import Firebase
//DOne

//MARK:- LoginPageViewController
class LoginPageViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    
    @IBOutlet weak var company_email_login: UITextField!
    
    
    @IBOutlet weak var password_login: UITextField!
    
    
    @IBOutlet weak var login_btn: UIButton!
    
    
    //MARK:-Signup btn
    @IBAction func signup_btn_login(_ sender: Any)
    {
        performSegue(withIdentifier: "LtoSSeg", sender: self)
    }
    
    
    //MARK:- Login btn
    @IBAction func login_btn(_ sender: Any)
    {
        let email = company_email_login.text
        let pass = password_login.text
        
        
        if((email?.lowercased()) != company_email_login.text)
        {
            print("Enter email in lower case");
        }
        else
        {
            Auth.auth().signIn(withEmail: email!, password: pass!) { (result, error) in
                if(error == nil)
                {
                    self.performSegue(withIdentifier: "LtoHSeg", sender: self);
                    UserDefaults.standard.setValue(email, forKey: "email");
                }
                else
                {
                    print("Invalid Error or Password")
                }
               
            }
        }
        
       
         
        
        /*
        db.collection(email!).whereField("Password", isEqualTo: pass!).getDocuments { (snapshot, error) in
            if(error == nil && snapshot != nil)
            {
                for documentData in snapshot!.documents
                {
                    let data = documentData.data()
                    
                    let email_ = data["Email"] as? String
                    
                    let pass_ = data["Password"] as? String
                    
                    if(pass_! == pass! && email_! == email)
                    {
                        self.performSegue(withIdentifier: "LtoHSeg", sender: self);
                        UserDefaults.standard.setValue(email_, forKey: "email");
                    }
                    else
                    {
                        print("Incorrect password")
                    }
                }
                
            }
            else
            {
                print("Invalid Email or Password")
            }
        }
         */
        
        
    }
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true

        //self.navigationController?.navigationBar.isHidden = true;
        
        //self.tabBarController?.viewWillDisappear(true)
        // Do any additional setup after loading the view.
        
        self.tabBarController?.tabBar.isHidden = true;
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        
        company_email_login.layer.cornerRadius = 20;
        company_email_login.layer.borderWidth = 1;
        company_email_login.clipsToBounds = true;
        
        password_login.layer.cornerRadius = 20;
        password_login.layer.borderWidth = 1;
        password_login.clipsToBounds = true;
        
        login_btn.layer.cornerRadius = 25;
        login_btn.layer.borderWidth = 1;
        login_btn.clipsToBounds = true;
        
        
        if Auth.auth().currentUser != nil
        {
            let user =  Auth.auth().currentUser
            if let user = user
            {
                let email = user.email;
                
                UserDefaults.standard.setValue(email, forKey: "email")
                
                performSegue(withIdentifier: "LtoHSeg", sender: self)
            }
           
        }
        else
        {
        
            
        }
        /*
        
        if(company_email_login.text == "" || password_login.text == "")
        {
            print("fields can't be empty")
        }
        else
        {
            if Auth.auth().currentUser != nil
            {
                let user =  Auth.auth().currentUser
                if let user = user
                {
                    let email = user.email;
                    
                    UserDefaults.standard.setValue(email, forKey: "email")
                    
                    performSegue(withIdentifier: "LtoHSeg", sender: self)
                }
               
            }
            else
            {
            
                
            }
        }
       
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
