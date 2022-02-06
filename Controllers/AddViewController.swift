//
//  AddViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 06/06/21.
//

import UIKit
import Firebase

//MARK:- AddViewController
class AddViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //var error = [String]()
    var e = "Error";
    
    //New way part 5
    //
    //let xx = HomeViewController();
    
    let db = Firestore.firestore();
    
    let storage = Storage.storage().reference()
    
    @IBOutlet weak var language_name: UITextField!
    
    @IBOutlet weak var error_textfield: UITextView!
    
    @IBOutlet weak var solution_textfield: UITextView!
    
    @IBOutlet weak var image_: UIImageView!
    
    @IBOutlet weak var saveBtnLabel: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    var lang_name = ""
    var error_txt = ""
    var ans_txt = ""
    
    
    //MARK:-Image
    @IBAction func img_btn(_ sender: Any)
    {
        if (UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum))
        {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        image_.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
    }

    //upload data
    //get download
    //save download url
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil )
    }
    
    //MARK:- Save btn
    @IBAction func save_btn(_ sender: Any)
    {
        let likes = 0
        //let status = false
        lang_name = language_name.text!
        
        error_txt = error_textfield.text
        
        ans_txt = solution_textfield.text
        
        let date = Date()
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        timeFormatter.dateFormat = "HH:mm:ss"
        let Date = dateFormatter.string(from: date)
        let Time = timeFormatter.string(from: date)
        let dateTime = Date + " " + Time
        
        let random = String(Int.random(in: 0..<999999))
        
        let email = UserDefaults.standard.string(forKey: "email")
        
        let username = UserDefaults.standard.string(forKey: "username")
        
        let profession = UserDefaults.standard.string(forKey: "profession")
        
        let uid = UserDefaults.standard.string(forKey: "userId")
        
        UserDefaults.standard.setValue(random, forKey: "random")
        
        UserDefaults.standard.setValue(lang_name, forKey: "langnameforimage")
        
        let reason1 = "You created error and provided solution"
        
        //upload image to database
        /*
        let imageData = (image_.image?.pngData())
        
        storage.child("\(lang_name) ID: \(random)/\(username!) ID: \(uid!)").putData(imageData!, metadata: nil) { (_, error) in
            if(error == nil)
            {
                self.storage.child("\(self.lang_name) ID: \(random)/\(username!) ID: \(uid!)").downloadURL { (url, error) in
                    if(error == nil && url != nil)
                    {
                        let urlString = url?.absoluteString
                        UserDefaults.standard.setValue(urlString, forKey: "imageurl")
                        print("Downloaded URL: \(urlString!)")
                        self.db.collection(email!).document(self.lang_name + " ID: " + random).updateData(["ImageUrl":urlString!])
                    }
                    else
                    {
                        print("URL didn't fetch")
                    }
                }
            }
            else
            {
                print("Error occured ")
            }
        }
        let imageurl = UserDefaults.standard.string(forKey: "imageurl")
        */
        
        db.collection(email!).document(lang_name + " ID: " + random).setData(["Type":e, "Language": lang_name, "ID": random,"Error":error_txt, "Solution":ans_txt, "Username":username!, "Profession":profession!, "Likes":likes, "Status":false, "DateTime":dateTime, "Date":Date, "Time":Time, "UserID":uid!, "ProfileHomeImg":"NoImg"])
        
        db.collection(email!).document(lang_name + " ID: " + random).collection("Solution").document("Solution ID: " + random).setData(["Type":"Solution", "SolutionA":ans_txt, "ID":random, "Likes":likes, "Status":false,"Username":username!, "Profession":profession!, "DateTime":dateTime, "Date":Date, "Time":Time, "SError":error_txt, "Reason":reason1, "UserID":uid!,"ProfileHomeImg":"NoImg"])
        
        db.collection(email!).document(username! + " ID: " + uid!).collection("USolution").document("Solution ID: " + random).setData(["Type":"Solution", "SolutionA":ans_txt, "ID":random, "Likes":likes, "Status":false,"Username":username!, "Profession":profession!, "DateTime":dateTime, "Date":Date, "Time":Time, "USError":error_txt, "Reason":reason1, "ImageUrl":"NoImg"])
        
        //Adding errors and solution to users
        db.collection(email!).document(username! + " ID: " + uid!).collection(email!).document(lang_name + " ID: " + random).setData(["Type":e, "Language": lang_name, "ID": random,"Error":error_txt, "Solution":ans_txt, "Username":username!, "Profession":profession!, "Likes":likes, "Status":false, "DateTime":dateTime, "Date":Date, "Time":Time, "SaveFlag":false, "ImageUrl":"NoImg"])
        
        db.collection(email!).document(username! + " ID: " + uid!).collection(email!).document(lang_name + " ID: " + random).collection("Solution").document("Solution ID: " + random).setData(["Type":"Solution", "SolutionA":ans_txt, "ID":random, "Likes":likes, "Status":false,"Username":username!, "Profession":profession!, "DateTime":dateTime, "Date":Date, "Time":Time, "SError":error_txt, "Reason":reason1, "SaveFlag":false, "ImageUrl":"NoImg"])
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //db.collection(lang_name).document(lang_name + " " + "Error: " + random).setData(["Error":error_txt, "Solution":ans_txt])
        
        
        //db.collection(lang_name).document(lang_name + " " + "Solution: " + random).setData(["Solution":ans_txt])
        
                
        self.performSegue(withIdentifier: "backHomeSeg", sender: self)
        
        language_name.text = ""
        error_textfield.text = ""
        solution_textfield.text = ""

        
        //xx.viewDidLoad();
        //addDocument(data: [ "Error \(lang_name) \(random)":error_txt, "Solution \(lang_name) \(random)":ans_txt  ])
        print("Saved btn called")
        
    }
    
    
    
    
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    
        self.navigationItem.hidesBackButton = true
        
        //let newBackBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(AddViewController.back(sender:)))
        
        //self.navigationItem.leftBarButtonItem = newBackBtn
        
        //newBackBtn.tintColor = .black
        
        error_textfield.layer.cornerRadius = 20;
        error_textfield.layer.borderWidth = 1;
        error_textfield.clipsToBounds = true;
        
        
        
        solution_textfield.layer.cornerRadius = 20;
        solution_textfield.layer.borderWidth = 1;
        solution_textfield.clipsToBounds = true;
        
        saveBtnLabel.layer.cornerRadius = 20;
        saveBtnLabel.layer.borderWidth = 1;
        saveBtnLabel.clipsToBounds = true;
        
        language_name.layer.cornerRadius = 20;
        language_name.layer.borderWidth = 1;
        language_name.clipsToBounds = true;
        
        
        
        
    }
    
    /*
    @objc func back(sender: UINavigationItem)
    {
        self.performSegue(withIdentifier: "backHomeSeg", sender: self)
    }
    */
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "backHomeSeg")
        {
            let errorseg = segue.destination as! HomeViewController
            errorseg.strError = error_textfield.text
        }
    }
     */
}
