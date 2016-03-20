//
//  PostedImageCell.swift
//  Instagram
//
//  Created by Donatea Zefi on 3/20/16.
//  Copyright © 2016 Donatea Zefi. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostedImageCell: UITableViewCell {

    @IBOutlet weak var postedImageView: PFImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var secondUsernameLabel: UILabel!
    
    @IBOutlet weak var profilePhotoView: UIImageView!
    
    @IBOutlet weak var timePostedLabel: UILabel!
   
    var imagePost: PFObject! {
        didSet {
            self.postedImageView.file = imagePost["media"] as? PFFile
            self.postedImageView.loadInBackground()
            self.captionLabel.text = imagePost["caption"] as? String
            self.usernameLabel.text = PFUser.currentUser()?.username
            self.secondUsernameLabel.text = PFUser.currentUser()?.username
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
