//
//  MenuViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 07/06/21.
//

import UIKit
struct MenuList
{
    var List : String
}
class MenuViewController: UIViewController {
    
    var list = [MenuList]()
    
    var dList = ["Java","Swift", "C#"]
    
    @IBOutlet weak var menu: UITableView!
    
    @IBOutlet weak var top_view: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu.delegate = self
        menu.dataSource = self
        
        
        for data in dList
        {
            let newData = MenuList(List: data)
            list.append(newData)
        }
        
        
        DispatchQueue.main.async {
            self.menu.reloadData()
        }
        
        self.menu.reloadData()
        // Do any additional setup after loading the view.
        
        //top_view.layer.cornerRadius = 20
        
    }
    

  
}

extension MenuViewController: UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("Menu Row Tapped: \(indexPath.row)")
    }
    
    
}

extension MenuViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        
        let data = list[indexPath.row]
        
        cell.lable.text = data.List
        
        return cell
    }
    
    
}
