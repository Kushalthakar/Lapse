//
//  CompanyViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 21/07/21.
//

import UIKit
import Firebase
//MARK:- Struct
struct CompanyItems
{
    var items : String
}
//MARK:- CompanyViewController
class CompanyViewController: UIViewController {

    @IBOutlet weak var table_view: UITableView!
    var db = Firestore.firestore()
    var labels = ["Users","Limit"]
    var items = [CompanyItems]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        table_view.delegate = self
        table_view.dataSource = self
        
        
        
        
        for m in labels
        {
            let new = CompanyItems(items: m)
            self.items.append(new)
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
//MARK:- TabelView
extension CompanyViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CompanyTableViewCell
        let data = items[indexPath.row]
        
        cell.label.text = data.items
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.row)")
        let email = UserDefaults.standard.string(forKey: "email")
        if(indexPath.row == 0)
        {
            performSegue(withIdentifier: "CtoUSeg", sender: self)
        }
        
        
        
        if(indexPath.row == 1)
        {
            //let email = UserDefaults.standard.string(forKey: "email")
            db.collection(email!).document(email!).getDocument { (snapshot, error) in
                if(error == nil && snapshot != nil)
                {
                    let currentcount = snapshot!.get("Count") as? Int ?? 0
                    let alert = UIAlertController(title: "Update Count", message: "Current employee count: \(currentcount)", preferredStyle: .alert)
                    alert.addTextField(configurationHandler: {textField in textField.placeholder = "Enter new count"})
                    alert.addAction(UIAlertAction(title: "Update", style: .default, handler: {action in
                        let count_ = Int((alert.textFields?.first?.text)!)
                        self.db.collection(email!).document(email!).updateData(["Count":count_!])
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    print("Error Occured")
                }
            }
        }
        
    }
    
}
