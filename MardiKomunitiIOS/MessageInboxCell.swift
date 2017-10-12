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
    @IBOutlet weak var projectNameLabel: UILabel!
    
    var message: Mesej! {
        didSet {
            self.updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func updateUI() {
        
        projectNameLabel.text = message.projectName
        titleLabel.text = message.title
        dateLabel.text = message.createdDate
        contentLabel.text = message.content
        
        imageFeatured.backgroundColor = .orange
        imageFeatured.circledView(imageFeatured.frame.width)
        
        ZGraphics().createImageWithLetter(message.projectName!, imageView: imageFeatured, fontSize: imageFeatured.frame.width / 2)
    }
}















