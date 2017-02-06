//
//  ProjectFViewController.swift
//  ProjectF
//
//  Created by Victor Hong on 06/02/2017.
//  Copyright © 2017 Victor Hong. All rights reserved.
//

import UIKit
import ParseUI

class ProjectFViewController: PFQueryTableViewController {

    let cellIdentifier: String = "FitCell"
    
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
        
        self.pullToRefreshEnabled = true
        self.paginationEnabled = true
        self.objectsPerPage = 25
        
        self.parseClassName = className
        
        self.tableView.rowHeight = 350
        
        // TODO: change this?
        self.tableView.allowsSelection = false
    }
    
    required init(coder aDecoder:NSCoder)  
    {
        fatalError("NSCoding not supported")  
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "FitTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func queryForTable() -> PFQuery<PFObject> {
        
        let query: PFQuery = PFQuery(className: self.parseClassName!)
        
        if objects?.count == 0 {
            
            query.cachePolicy = PFCachePolicy.cacheThenNetwork
            
        }
        
        //TODO: change string.
        
        query.order(byAscending: "name")
        
        return query
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, object: PFObject?) -> PFTableViewCell? {
        
        var cell: FitTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FitTableViewCell
        
        if cell == nil {
            
            cell = Bundle.main.loadNibNamed("FitTableViewCell", owner: self, options: nil)?[0] as? FitTableViewCell
            
        }
        
        if let pfObject = object {
            cell?.fitNameLabel.text = pfObject["name"] as? String
            
            var votes: Int? = pfObject["votes"] as? Int
            if votes == nil {
                votes = 0
            }
            cell?.fitVoteLabel.text = "\(votes!) votes"
            
            cell?.fitImageView.image = placeholderImage
            
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

