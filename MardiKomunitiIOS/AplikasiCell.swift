//
//  AplikasiCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 02/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class AplikasiCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImage : UIImageView!
    @IBOutlet weak var aplikasiName : UILabel!
    
    func updateCell(_ name: String, image: UIImage) {
        
        //setting for auto shrink to fit the label.
        aplikasiName.numberOfLines = 2
        aplikasiName.lineBreakMode = .byTruncatingTail
        aplikasiName.minimumScaleFactor = 0.5
        
        aplikasiName.text = name
        featuredImage.image = image
    }
    
}
