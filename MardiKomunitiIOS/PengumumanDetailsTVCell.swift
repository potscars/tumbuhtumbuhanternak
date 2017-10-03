//
//  PengumumanDetailsTVCell.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class PengumumanDetailsTVCell: UITableViewCell {
    
    @IBOutlet weak var uilPDTVCSenderName: UILabel!
    @IBOutlet weak var uilPDTVCSenderDate: UILabel!
    @IBOutlet weak var uiivPDTVCArticleImage: UIImageView!
    @IBOutlet weak var uilPDTVCArticleFullDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
