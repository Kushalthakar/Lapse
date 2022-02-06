//
//  InstructionViewController.swift
//  StartUpIdea1
//
//  Created by Kushal Thakar on 18/07/21.
//

import UIKit
import AVKit
import AVFoundation

//MARK:- Instruction
class InstructionViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    
    var index = 0
    
    let introductionPages = ["App available in the market to track the user engagement and usage on your app.","LAPSE app will provide that feature to store errors and their solution.","There will be threads to an error, different people can also suggest solution for a particular error.","There will be a rating system for error so that highly rated error for the most difficult one to solve and has the best solution.","The main advantage of LAPSE app is that it will save time for the company."]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        pageController.numberOfPages = introductionPages.count
        
        pageController.currentPage = index
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

extension InstructionViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return introductionPages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pages = collectionView.dequeueReusableCell(withReuseIdentifier: "pages", for: indexPath) as! PageCollectionViewCell
        let data = introductionPages[indexPath.row]
        pages.instructionLabel.text = data
        return pages
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width:collectionView.frame.size.width, height:collectionView.frame.size.height)
    }
    
   
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let pageWidth = self.collectionView.frame.size.width
    self.pageController.currentPage = Int(self.collectionView.contentOffset.x / pageWidth)
    }
    
    
}
