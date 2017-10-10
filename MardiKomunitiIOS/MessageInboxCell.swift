//
//  MessageInboxCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 04/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class MessageInboxCell: UITableViewCell {

    @IBOutlet weak var imageFeatured : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var contentLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let string = "Kim Byung Man"
        
        imageFeatured.backgroundColor = .orange
        imageFeatured.circledView(imageFeatured.frame.width)
        
        ZGraphics().createImageWithLetter(string, imageView: imageFeatured, fontSize: 20.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}















