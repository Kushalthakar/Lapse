//
//  SignUpPageViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 20/06/21.
//

import UIKit
import FirebaseAuth
import Firebase
import  MessageUI

//MARK:- SignupPageViewController
class SignUpPageViewController: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var signUpBtnO: UIButton!
    
    @IBOutlet weak var companyNameTv: UITextField!
    @IBOutlet weak var companyEmailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var cPassTF: UITextField!
    
    
    //MARK:- Login btn
    @IBAction func login_btn_signup(_ sender: UIButton)
    {
        performSegue(withIdentifier: "StoLSeg", sender: self)
    }
    
    //MARK:- Mail
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    func email_(key:String, email:String)
    {
        if(MFMailComposeViewController.canSendMail())
        {
            let mailVc = MFMailComposeViewController()
            mailVc.delegate = self
            mailVc.setToRecipients([email])
            mailVc.setSubject("Recovery Key for company")
            mailVc.setMessageBody("Recovery Key: \(key)", isHTML: false)
            present(UINavigationController(rootViewController: mailVc), animated: true, completion: nil)
        }
        else
        {
            print("Cant send")
        }
         
    }
    
    //MARK:- Signup btn
    @IBAction func signup_btn(_ sender: Any)
    {
        let companyName = companyNameTv.text
        let email = companyEmailTF.text
        let pass = passTF.text
        
        print(email!)
        print(pass!)
        if(email == "" || pass == "" || companyNameTv.text == "" || cPassTF.text == "")
        {
            print("Cant be empty")
        }
        
        else
        {
            if(email?.lowercased() != companyEmailTF.text)
            {
                print("Enter email in lowercase")
            }
            
            else
            {
                Auth.auth().createUser(withEmail: email!, password: pass!) { (result, error) in
                    if (error == nil)
                    {
                        print("Data added")
                        let random = String(Int.random(in: 0..<999999))
                        self.db.collection(email!).document(email!).setData(["CompanyName":companyName!, "Email": email!, "Password": pass!, "Count":100, "RecoveryKey":random])
                        
                        self.email_(key: random, email: email!)
                        
                       
                        /*
                        
                        */
                        //self.performSegue(withIdentifier: "StoLSeg", sender: self)
                    }
                    else
                    {
                        print(error?.localizedDescription as Any)
                        print("error")
                    }
                }
            }
            
           
            
            
        
        }
       
    }
        

    @IBOutlet weak var cnTvLabel: UITextField!
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        self.tabBarController?.tabBar.isHidden = true;
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true

        companyNameTv.layer.cornerRadius = 20;
        companyNameTv.layer.borderWidth = 1;
        companyNameTv.clipsToBounds = true;
        
        companyEmailTF.layer.cornerRadius = 20;
        companyEmailTF.layer.borderWidth = 1;
        companyEmailTF.clipsToBounds = true;
        
        
        signUpBtnO.layer.cornerRadius = 20;
        signUpBtnO.layer.borderWidth = 1;
        signUpBtnO.clipsToBounds = true;
        
        passTF.layer.cornerRadius = 20;
        passTF.layer.borderWidth = 1;
        passTF.clipsToBounds = true;
        
        cPassTF.layer.cornerRadius = 20;
        cPassTF.layer.borderWidth = 1;
        cPassTF.clipsToBounds = true;
        
        

 
    }
    


}
