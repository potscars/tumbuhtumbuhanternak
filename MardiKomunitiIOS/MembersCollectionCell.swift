//
//  MembersCollectionCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 04/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class MembersCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageFeatured : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    func updateUI() {
        
        let name = "Kim Jong Kook"
        
        imageFeatured.backgroundColor = .purple
        imageFeatured.circledView(imageFeatured.frame.width)
        
        ZGraphics().createImageWithLetter(name, imageView: imageFeatured, fontSize: imageFeatured.frame.width / 2)
        
        nameLabel.text = name
    }
}
