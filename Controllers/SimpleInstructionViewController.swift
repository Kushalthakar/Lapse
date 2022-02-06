//
//  SimpleInstructionViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 18/07/21.
//

import UIKit
import Firebase

class SimpleInstructionViewController: UIViewController {

    @IBOutlet weak var view_design: UIView!
    
    @IBOutlet weak var tv_label: UITextView!
    
   
    @IBAction func switch_action(_ sender: UISwitch)
    {
        if sender.isOn
        {
            performSegue(withIdentifier: "checking", sender: self)
        }
        else
        {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tv_label.text = ""
        // Do any additional setup after loading the view.
        tv_label.layer.cornerRadius = 10
        tv_label.clipsToBounds = true
        
        view_design.layer.cornerRadius = 10
        view_design.layer.shadowRadius = 10
        view_design.layer.shadowOffset = CGSize(width: 5, height: 5)
        view_design.layer.shadowOpacity = 0.3
        
        
        
        if Auth.auth().currentUser != nil
        {
            let user =  Auth.auth().currentUser
            if let user = user
            {
                let email = user.email;
                
                UserDefaults.standard.setValue(email, forKey: "email")
                
                performSegue(withIdentifier: "checking", sender: self)
            }
           
        }
        else
        {
        
            
        }
        
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
