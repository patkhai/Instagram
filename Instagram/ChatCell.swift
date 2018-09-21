//
//  ChatCell.swift
//  Instagram
//
//  Created by Pat Khai on 9/21/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit


class ChatCell: UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
