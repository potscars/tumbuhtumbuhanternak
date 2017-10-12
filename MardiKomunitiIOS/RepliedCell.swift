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
    
    var respond: Respond! {
        didSet {
            self.updateUI()
        }
    }

    private func updateUI() {
        
        senderLabel.text = respond.responderName
        positionLabel.text = respond.responderCaption
        contentLabel.text = respond.responderMessage
        
        imageFeatured.backgroundColor = .green
        imageFeatured.circledView(imageFeatured.frame.width)
        
        ZGraphics().createImageWithLetter(respond.responderName!, imageView: imageFeatured, fontSize: imageFeatured.frame.width / 2)
    }

}
