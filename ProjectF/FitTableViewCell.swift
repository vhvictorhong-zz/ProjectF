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

    @IBOutlet weak var fitImageView: PFImageView!
    @IBOutlet weak var fitNameLabel: UILabel!
    @IBOutlet weak var fitVoteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
