//
//  ContentCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 04/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {
    
    @IBOutlet weak var imageFeatured : UIImageView!
    @IBOutlet weak var senderLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var contentLabel : UILabel!
    @IBOutlet weak var replyButton : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageFeatured.backgroundColor = .orange
        imageFeatured.circledView(imageFeatured.frame.width)
        
        ZGraphics().createImageWithLetter("Kim Byung Man", imageView: imageFeatured, fontSize: 16.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
