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

    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
        
        self.pullToRefreshEnabled = true
        self.paginationEnabled = true
        self.objectsPerPage = 25
        
        self.parseClassName = className
    }
    
    required init(coder aDecoder:NSCoder)  
    {
        fatalError("NSCoding not supported")  
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func queryForTable() -> PFQuery<PFObject> {
        
        var query: PFQuery = PFQuery(className: self.parseClassName!)
        
        if objects?.count == 0 {
            
            query.cachePolicy = PFCachePolicy.cacheThenNetwork
            
        }
        
        //TODO: change string.
        
        query.order(byAscending: "name")
        
        return query
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, object: PFObject?) -> PFTableViewCell? {
        
        let cellIdentifier: String = "Cell"
        
        var cell: PFTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? PFTableViewCell
        
        if cell == nil {
            
            cell = PFTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
            
        }
        
        if let pfObject = object {
            cell?.textLabel?.text = pfObject["name"] as? String
        }
        
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

