//
//  RepliedCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 04/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class RepliedCell: UITableViewCell {

    @IBOutlet weak var imageFeatured : UIImageView!
    @IBOutlet weak var senderLabel : UILabel!
//    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var positionLabel : UILabel!
    @IBOutlet weak var contentLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageFeatured.backgroundColor = .green
        imageFeatured.circledView(imageFeatured.frame.width)
        
        ZGraphics().createImageWithLetter("Seo Chan Hee", imageView: imageFeatured, fontSize: 16.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
