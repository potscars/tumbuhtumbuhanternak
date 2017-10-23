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
    
    func updateUI(_ index: Int, projek: Projek) {
        var enrollTemp = ""
        
        guard let name = projek.name else { return; }
        projekTitleLabel.text = name
        
        for enroll in projek.enrolls! {
            
            
            if enroll.agency! == "" {
                enrollTemp += "\(enroll.name!)\n"
            } else {
                enrollTemp += "\(enroll.name!) - \(enroll.agency!)\n"
            }
            
        }
        
        projekContentLabel.text = enrollTemp
        
        featuredImage.circledView(featuredImage.frame.width)
        ZGraphics().createImageWithLetter(name, imageView: featuredImage, fontSize: featuredImage.frame.width / 2)
    }
}








