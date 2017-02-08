//
//  FitTableViewCell.swift
//  ProjectF
//
//  Created by Victor Hong on 06/02/2017.
//  Copyright © 2017 Victor Hong. All rights reserved.
//

import UIKit
import ParseUI

class FitTableViewCell: PFTableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var fitImageView: PFImageView!
    @IBOutlet weak var fitNameLabel: UILabel!
    @IBOutlet weak var fitLikesLabel: UILabel!
    @IBOutlet weak var fitUserLabel: UIButton!
    @IBOutlet weak var fitCaptionLabel: UILabel!
    @IBOutlet weak var likeIconImageView: UIImageView!
    
    var parseObject: PFObject?

    // MARK: - View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        let gesture = UITapGestureRecognizer(target: self, action:#selector(onDoubleTap(sender:)))
        gesture.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(gesture)
        
        likeIconImageView?.isHidden = true
        
    }
    
    // MARK: - Actions
    
    func onDoubleTap(sender:AnyObject) {
        
        if(parseObject) != nil {
            if var likes = parseObject!.object(forKey: "likes") as? Int {
                likes += 1
                
                parseObject?.setObject(likes, forKey: "likes")
                parseObject?.saveInBackground()
                fitLikesLabel.text = "\(likes) likes"
            }
        }
        
        likeIconImageView?.isHidden = false
        likeIconImageView?.alpha = 1.0
        
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .allowAnimatedContent, animations: {
            
            self.likeIconImageView?.alpha = 0
            
        }) { (value:Bool) in
            
            self.likeIconImageView?.isHidden = true

        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
