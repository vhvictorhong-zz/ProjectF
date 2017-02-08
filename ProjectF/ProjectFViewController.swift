//
//  ProjectFViewController.swift
//  ProjectF
//
//  Created by Victor Hong on 06/02/2017.
//  Copyright © 2017 Victor Hong. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProjectFViewController: PFQueryTableViewController {

    // MARK: - Properties
    
    let cellIdentifier: String = "FitCell"
 
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Fit"
        
        tableView.register(UINib(nibName: "FitTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        self.tableView.rowHeight = 380
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if PFUser.current() == nil {
            let loginVC = PFLogInViewController()
            loginVC.delegate = self
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Parse Setup
    
    override func queryForTable() -> PFQuery<PFObject> {
        
        let query: PFQuery = PFQuery(className: "Food")
        
        if objects?.count == 0 {
            
            query.cachePolicy = PFCachePolicy.cacheThenNetwork
            
        }
        
        //TODO: change string.
        
        query.order(byAscending: "createdAt")
        
        return query
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, object: PFObject?) -> PFTableViewCell? {
        
        var cell: FitTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FitTableViewCell
        
        if cell == nil {
            
            cell = Bundle.main.loadNibNamed("FitTableViewCell", owner: self, options: nil)?[0] as? FitTableViewCell
            
        }
        
        cell?.parseObject = object
        
        if let pfObject = object {
            
            cell?.fitUserLabel.setTitle(pfObject["username"] as? String, for: .normal)
            
            cell?.fitNameLabel.text = pfObject["username"] as? String
            cell?.fitCaptionLabel.text = pfObject["caption"] as? String
            
            var likes: Int? = pfObject["likes"] as? Int
            if likes == nil {
                likes = 0
            }

            cell?.fitLikesLabel.text = "\(likes!) likes"
            
            let imageFile = pfObject["imageFile"] as? PFFile
            cell?.fitImageView.file = imageFile
            cell?.fitImageView.loadInBackground()
            
        }
        
        
        tableView.separatorStyle = .none
        
        return cell
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: PFLogInViewControllerDelegate

extension ProjectFViewController: PFLogInViewControllerDelegate {
    
}
