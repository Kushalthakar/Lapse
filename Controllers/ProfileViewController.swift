//
//  ProfileViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 21/06/21.
//

import UIKit
import Firebase

//MARK:- Struct
struct Menu {
    var  list : String
    
}
struct PTotalLikes {
    var Likes : Int
}


//MARK:- ProfileViewController
class ProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var menuList = [Menu]()
    var m = ["Update Profile", "History", "Saved","LeaderBoard", "Want to earn money?","Company","Logout"]
    var db = Firestore.firestore()
    @IBOutlet weak var image_: UIImageView!
    let imagePicker = UIImagePickerController()
    let storage = Storage.storage().reference()
    @IBOutlet weak var table_view: UITableView!
    
    @IBOutlet weak var pv: UIView!
    @IBOutlet weak var profImg: UIImageView!
    
    
    @IBAction func img_btn(_ sender: Any) {
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
    
   
    @IBAction func updateBtn(_ sender: Any)
    {
        //upload image to database
        print("Uploading Image")
        let imageData = (image_.image?.pngData())
        let email = UserDefaults.standard.string(forKey: "email")
        let u_sername = UserDefaults.standard.string(forKey: "username") ?? "Guest"
        let userID = UserDefaults.standard.string(forKey: "userId") ?? "11111" //
        
        storage.child("\(u_sername) ID: \(userID)/\(u_sername) ID: \(userID)").putData(imageData!, metadata: nil) { (_, error) in
            if(error == nil)
            {
                self.storage.child("\(u_sername) ID: \(userID)/\(u_sername) ID: \(userID)").downloadURL { (url, error) in
                    if(error == nil && url != nil)
                    {
                        let urlString = url?.absoluteString
                        UserDefaults.standard.setValue(urlString, forKey: "imageurl")
                        print("Downloaded URL: \(urlString!)")
                        self.db.collection(email!).document(u_sername + " ID: " + userID).updateData(["ImageUrl":urlString!])
                        //self.db.collection(email!).document()
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
    }
    
    @IBOutlet weak var top_constrain_sort: NSLayoutConstraint!
    
    var sortFlag = false;
    var structPTotalLikes = [PTotalLikes]()
    let imageurl = UserDefaults.standard.string(forKey: "imageurl")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profImg.layer.cornerRadius = 10
        profImg.layer.shadowOffset = CGSize(width: 5, height: 5)
        profImg.layer.shadowRadius = 10
        profImg.layer.shadowOpacity = 0.3
        
        pv.layer.cornerRadius = 10
        pv.layer.shadowOffset = CGSize(width: 5, height: 5)
        pv.layer.shadowRadius = 10
        pv.layer.shadowOpacity = 0.3
        
        menuList = []
        
        self.navigationController?.title = UserDefaults.standard.string(forKey: "username")
        
        

        table_view.dataSource = self;
        table_view.delegate = self;
        
        for data in m
        {
            let newlist = Menu(list: data)
            menuList.append(newlist)
        }
        print(menuList)
        
        let email = UserDefaults.standard.string(forKey: "email")
        let u_sername = UserDefaults.standard.string(forKey: "username") ?? "Guest"
        let userID = UserDefaults.standard.string(forKey: "userId") ?? "11111" //
        //let solusername = UserDefaults.standard.string(forKey: "s_u_sername") ?? "NO one"
        //let puid = UserDefaults.standard.string(forKey: "puid") ?? "No u Id" //User
        //let p_pro = UserDefaults.standard.string(forKey: "p_pro") ?? "no profession"
        let Uprofession = UserDefaults.standard.string(forKey: "profession") ?? "No u Profession"
        
        //MARK:- Main Profile IMAGE
        /*
        db.collection(email!).document(u_sername + " ID: " + userID).getDocument { (snapshot, error) in
            if(snapshot != nil && error == nil)
            {
                let data = snapshot?.get("ImageUrl");
                print("imageurl: \(data ?? "NoValue")")
                let url_ = URL(string: data as! String)!
                
                let task = URLSession.shared.dataTask(with: url_, completionHandler: {data, _, error in
                    
                    guard let data = data, error == nil else{
                        return
                    }
                    DispatchQueue.main.async{
                        let image = UIImage(data: data)
                        self.image_.image = image
                    }
                })
                task.resume()
            }
        }
        */
        
        
        
        
        
        db.collection(email!).document(u_sername + " ID: " + userID).collection("Nlikes").whereField("Type", isEqualTo: "NLikes").getDocuments { (snapshot, error) in
            if(error == nil && snapshot != nil)
            {
                var sum = 0
                for documents in snapshot!.documents
                {
                    let data = documents.data()
                    let likes = data["Likes"] as? Int ?? 0
                    let ulname = data["LikedBy"] as? String ?? "no name found"
                    if(ulname == u_sername)
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
               
                let newdata = PTotalLikes(Likes:sumLikes)
                self.structPTotalLikes.append(newdata)
                
                if(u_sername == "Guest")
                {
                    
                }
                else
                {
                    self.db.collection(email!).document("Leaderboard").collection("TotalLikes").document(u_sername + " ID: " + userID).setData(["Type":"TotalLikes", "Likes":sum,"Name":u_sername, "Profession":Uprofession])
                }
            }
            else
            {
                print("Error")
            }
        }
    
    }
    
    //MARK:- Profile Image
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

func logout()
{
    if (Auth.auth().currentUser != nil)
    {
        do
        {
            try Auth.auth().signOut()
            
        }
        catch
        {
            print("Exception")
        }

    }
    else
    {
        
    }
}

//MARK:- TableView
extension ProfileViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = menuList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileTableViewCell;
        
        
        cell.label.text = data.list;
        
        //cell.update_user_profile.text = "Update Profile"
        
        return cell;
    }
    
    
}

extension ProfileViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row)");
        /*
        if(indexPath.row == 0)
        {
            print("Sort Called \(indexPath.row)")
            
            if(sortFlag == false)
            {
                top_constrain_sort.constant = 700
                sortFlag = true
            }
            else
            {
                top_constrain_sort.constant = 889
                sortFlag = false
            }
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: self.view.layoutIfNeeded)
            {
                (animatinComplete) in
                    print("The Animation is complete")
            }
            
        }
        */
        
        if(indexPath.row == 0)
        {
            print("Update Called")
            /*
            let vc = (storyboard?.instantiateViewController(identifier: "UpdateUserViewController") as! UpdateUserViewController)
            
            present(vc, animated: true, completion: nil)
            */
            
            performSegue(withIdentifier: "PtoUpdatePSeg", sender: self)
            
            
        }
        if(indexPath.row == 1)
        {
            print("History")
            performSegue(withIdentifier: "ProfileToHistorySeg", sender: self)
        }
        if(indexPath.row == 2)
        {
            print("Saved")
            performSegue(withIdentifier: "ProfileToSaveSeg", sender: self)
        }
        if(indexPath.row == 3)
        {
            print("LeaderBoard called")
            performSegue(withIdentifier: "ProfileToLeaderboardSeg", sender: self)
        }
        
        if(indexPath.row == 4)
        {
            print("Subscribe called")
            performSegue(withIdentifier: "ProfileToSubSeg", sender: self)
        }
        if(indexPath.row == 5)
        {
            let email = UserDefaults.standard.string(forKey: "email")
            print("Company called")
            let alert = UIAlertController(title: "Recovery Key", message: "Enter Recovery Key", preferredStyle: .alert)
            alert.addTextField(configurationHandler: {textField in textField.placeholder = "Enter Recovery key here"})
            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
                let key = alert.textFields?.first?.text
                self.db.collection(email!).document(email!).getDocument { (snapshot, error) in
                    if(error == nil && snapshot != nil)
                    {
                        let key_ = snapshot?.get("RecoveryKey") as? String ?? "0"
                        if(key == key_)
                        {
                            self.performSegue(withIdentifier: "ProfileToCompanySeg", sender: self)
                        }
                        else
                        {
                            print("didnt matched")
                        }
                    }
                    else
                    {
                        print("Error Occured")
                    }
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }
        if(indexPath.row == 6)
        {
            if (Auth.auth().currentUser != nil)
            {
                UserDefaults.standard.setValue("Guest", forKey: "username")
                UserDefaults.standard.setValue("p", forKey: "profession")
                UserDefaults.standard.setValue("12345", forKey: "userId" )
                
                do
                {
                    try Auth.auth().signOut()
                    //self.tabBarController?.viewWillDisappear(true)
                    UserDefaults.standard.setValue("", forKey: "email")
                    performSegue(withIdentifier: "PtoLSeg", sender: self)
                    
                    
                    
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
        }
        
        
    }
}

//MARK:- Tabbar
extension ProfileViewController: UITabBarDelegate, UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if(tabBarIndex == 0)
        {
            print("Profile Home called")
            //table_view.reloadData()
            //view.reloadInputViews()
            table_view.reloadData()
            viewDidLoad()
            //table_view.reloadData()
        }
        if(tabBarIndex == 1)
        {
            print("Profile Notification called")
            //NotificationCenter.default.post(name: Notification.Name(rawValue: "ReloadPage"), object: nil)
            table_view.reloadData()
            viewDidLoad()
        }
        if(tabBarIndex == 2)
        {
            print("Profile Profile called")
            table_view.reloadData()
            viewDidLoad()
        }
    }
    
    
}
