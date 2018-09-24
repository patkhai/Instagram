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
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    var updatePost: Post! {
        didSet {
            self.postImage.file = updatePost.media
            self.postImage.loadInBackground()
        
            self.idLabel.text = PFUser.current()!.username!
            
            self.caption.text = updatePost.caption
            
            self.dateLabel.text = updatePost.date
            self.label.text = PFUser.current()!.username!
            self.avatar()
            
       
            
        }
    }

    func avatar() {
        let avatar = PFUser.current()!.username!
        // Set the avatar
        avatarImage.layer.cornerRadius = 15;
        avatarImage.layer.borderColor  = UIColor(white: 0.7, alpha: 0.8).cgColor
        avatarImage.layer.borderWidth = 1;
        avatarImage.af_setImage(withURL: URL(string: "https://api.adorable.io/avatars/40/\(avatar)")!)
        
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
