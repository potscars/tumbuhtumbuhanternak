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
            
            enrollTemp += "\(enroll.name!) - \(enroll.agency!)\n"
        }
        
        let  finalEnroll = enrollTemp.substring(to: enrollTemp.index(enrollTemp.endIndex, offsetBy: -4))
        projekContentLabel.text = enrollTemp
        
        featuredImage.circledView(featuredImage.frame.width)
        ZGraphics().createImageWithLetter(name, imageView: featuredImage, fontSize: featuredImage.frame.width / 2)
    }
}
