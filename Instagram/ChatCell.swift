//
//  ChatCell.swift
//  Instagram
//
//  Created by Pat Khai on 9/21/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ChatCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var objectLike: UILabel!
    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    
    @IBOutlet weak var label: UILabel!
    
    var updatePost: Post! {
        didSet {
            self.postImage.file = updatePost.media
            self.postImage.loadInBackground()
            
            self.idLabel.text = PFUser.current()!.username!
            
            self.caption.text = updatePost.caption
            
            self.dateLabel.text = updatePost.date
            self.label.text = PFUser.current()!.username!
            
            
       
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
