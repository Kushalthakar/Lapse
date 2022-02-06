//
//  SubscribePageViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 18/07/21.
//

import UIKit
import StoreKit

//MARK:- SubscribePageViewController
class SubscribePageViewController: UIViewController,SKProductsRequestDelegate, SKPaymentTransactionObserver, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let product = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubscribeTableViewCell
        cell.sub_label.text = "Subscribe"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("selected \(indexPath.row)")
        //sow purchase
        let payment = SKPayment(product: models[indexPath.row])
        SKPaymentQueue.default().add(payment)
    }

    @IBOutlet weak var view_design: UIView!
    
    @IBOutlet weak var table_view: UITableView!
    
    @IBOutlet weak var instruct: UILabel!
    
    @IBOutlet weak var sub_btn_label: UIButton!
    
    private var models = [SKProduct]()
    
    enum Product: String, CaseIterable{
        //case lapsePremium =  "com.myapp.Lapse_Premium"
        case LapsePremium = "com.myapp.Lapse_Premium"
       }
    
    
    
    
    @IBAction func sub_btn(_ sender: UIButton)
    {
        print("calling for subscribe")
        //let payment = SKPayment(product: models[])
        //SKPaymentQueue.default().add()
    }
   
       private func fetchProducts(){
           let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({$0.rawValue})))
           request.delegate = self
           request.start()
       }
       func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
           DispatchQueue.main.async {
               print("Count\(response.products.count)")
               self.models = response.products
                self.table_view.reloadData()
           }
       }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
            //future developnment
        }
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        instruct.text = "If you subscribe to this application you get the advantage of earning money on the likes you get on the solution. Along with that you will be able to upload an Image which can make your solutions more clear and attractive."
        /* "If you subscribe to this application you get the advantage of earning money on the likes you get on the solution. Along with that you will be able to upload an Image which can make your solutions more clear and attractive."*/
        //sub_btn_label.layer.cornerRadius = 10
        view_design.layer.cornerRadius = 10
        view_design.layer.shadowOffset = CGSize(width: 5, height: 5)
        view_design.layer.shadowRadius = 10
        view_design.layer.shadowOpacity = 0.3
        
        table_view.delegate = self
        table_view.dataSource = self
        SKPaymentQueue.default().add(self)
        fetchProducts()
        
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

