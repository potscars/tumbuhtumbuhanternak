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
    
    
    var message: Mesej! {
        didSet{
            self.updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    private func updateUI() {
        
        senderLabel.text = message.engagesName
        dateLabel.text = message.createdDate
        titleLabel.text = message.title
        contentLabel.text = message.content
        
        imageFeatured.backgroundColor = .orange
        imageFeatured.circledView(imageFeatured.frame.width)
        
        ZGraphics().createImageWithLetter(senderLabel.text!, imageView: imageFeatured, fontSize: imageFeatured.frame.width / 2)
    }

}
