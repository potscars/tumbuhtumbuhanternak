//
//  AnnouncementTVCell.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 02/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class AnnouncementTVCell: UITableViewCell {
    
    //ATVCNonPicture
    @IBOutlet weak var uilATVCTitleNonPic: UILabel!
    @IBOutlet weak var uilATVCDescNonPic: UILabel!
    
    //ATVCPicture
    @IBOutlet weak var uiivATVCImage: UIImageView!
    @IBOutlet weak var uilATVCTitlePic: UILabel!
    @IBOutlet weak var uilATVCDescPic: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
