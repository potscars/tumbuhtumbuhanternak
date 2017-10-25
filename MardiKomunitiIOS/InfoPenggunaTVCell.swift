//
//  InfoPenggunaTVCell.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class InfoPenggunaTVCell: UITableViewCell {
    
    @IBOutlet weak var uilIPTVCUserName: UILabel!
    @IBOutlet weak var uilIPTVCProfileDesc: UILabel!
    
    @IBOutlet weak var uiivIPTVCSettingsIcon: UIImageView!
    @IBOutlet weak var uilIPTVCSettingsName: UILabel!
    @IBOutlet weak var uilIPTVCSettingsNameOneLetter: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUserProfile(data: NSDictionary) {
        
        let senderName: String = data.value(forKey: "PROFILE_USERNAME") as? String ?? "Tiada Nama"
        uilIPTVCUserName.text = senderName
        uilIPTVCSettingsNameOneLetter.text = senderName[0]
        uilIPTVCSettingsNameOneLetter.textColor = UIColor.white
        uilIPTVCSettingsNameOneLetter.layer.backgroundColor = UIColor.purple.cgColor
        uilIPTVCSettingsNameOneLetter.layer.cornerRadius = 33
        uilIPTVCProfileDesc.text = "Melihat Profil Data"
    }
    
    func updateSettings(data: NSDictionary) {
        
        uiivIPTVCSettingsIcon.image = UIImage.init(named: data.value(forKey: "MENU_ICON") as? String ?? "")?.resizeImageWith(newSize: CGSize.init(width: 40, height: 40), opaque: false)
        uilIPTVCSettingsName.text = data.value(forKey: "MENU_NAME") as? String ?? "Data Tidak Sah"
        
        
    }

}
