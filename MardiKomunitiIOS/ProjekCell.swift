//
//  ProjekCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 06/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class ProjekCell: UITableViewCell {

    @IBOutlet weak var featuredImage : UIImageView!
    @IBOutlet weak var projekTitleLabel : UILabel!
    @IBOutlet weak var projekContentLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(_ data: Projek) {
        
        projekTitleLabel.text = data.title
        projekContentLabel.text = data.members
        
        featuredImage.circledView(featuredImage.frame.width)
        ZGraphics().createImageWithLetter(projekTitleLabel.text!, imageView: featuredImage, fontSize: featuredImage.frame.width / 2)
    }
}
