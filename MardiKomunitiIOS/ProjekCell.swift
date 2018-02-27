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
        
//        if (projek.enrolls?.count)! > 0 {
//            for (index, enroll) in projek.enrolls!.enumerated() {
//
//                if enroll.agency! == "" {
//                    if index == (projek.enrolls?.count)! - 1 {
//                        enrollTemp += "\(enroll.name!)"
//                    } else {
//                        enrollTemp += "\(enroll.name!)\n"
//                    }
//                } else {
//                    if index == (projek.enrolls?.count)! - 1 {
//                        enrollTemp += "\(enroll.name!) - \(enroll.agency!)"
//                    } else {
//                        enrollTemp += "\(enroll.name!) - \(enroll.agency!)\n"
//                    }
//                }
//            }
//        } else {
//            enrollTemp = "Tiada ahli buat ketika ini."
//        }
//
//        projekContentLabel.text = enrollTemp
        
        featuredImage.backgroundColor = UIColor.customDarkGray
        featuredImage.circledView(featuredImage.frame.width)
        ZGraphics().createImageWithLetter(name, imageView: featuredImage, fontSize: featuredImage.frame.width / 2)
    }
}








