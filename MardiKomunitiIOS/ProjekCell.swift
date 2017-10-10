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
    
//    var projek: Projek! {
//        didSet {
//            self.updateUI()
//        }
//    }
    
    func updateUI(_ index: Int, projek: Projek) {
        print(index)
        print(projek.name)
        print(projek.dateStart)
        print(projek.id)
        print(projek.projekCategory)
        
        guard let name = projek.name else { return; }
        projekTitleLabel.text = name
        //print(projek.enrolls?.count)
        featuredImage.circledView(featuredImage.frame.width)
        ZGraphics().createImageWithLetter("Rocky Stomp", imageView: featuredImage, fontSize: featuredImage.frame.width / 2)
    }
}
