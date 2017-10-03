//
//  PengumumanTVCell.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class PengumumanTVCell: UITableViewCell {

    @IBOutlet weak var uilPVCNPTitle: UILabel!
    @IBOutlet weak var uilPVCNPDesc: UILabel!
    
    @IBOutlet weak var uiivPVCWPImage: UIImageView!
    @IBOutlet weak var uilPVCWPTitle: UILabel!
    @IBOutlet weak var uilPVCWPDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
