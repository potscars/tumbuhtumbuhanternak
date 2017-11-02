//
//  UserDetailsTVCell.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 12/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class UserDetailsTVCell: UITableViewCell {
    
    @IBOutlet weak var uilUDTVCSubInfo: UILabel!
    
    @IBOutlet weak var uiivUDTVCTwoInfoIcon: UIImageView!
    @IBOutlet weak var uilUDTVCTwoInfoBigText: UILabel!
    @IBOutlet weak var uilUDTVCTwoInfoSubText: UILabel!
    
    @IBOutlet weak var uiivUDTCOneInfoIcon: UIImageView!
    @IBOutlet weak var uilUDTVCOneInfoBigText: UILabel!
    @IBOutlet weak var uiivUDTVCUserAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellBanner() {
        
        
        
    }
    
    func updateCellTitle(data: String) {
        
        uilUDTVCSubInfo.text = data
        
    }
    
    func updateCellOneInfo(data: NSDictionary) {
        
        uiivUDTCOneInfoIcon.image = UIImage.init(named: data.value(forKey: "ONEINFO_ICONIMAGE") as? String ?? "Tiada Maklumat")
        uilUDTVCOneInfoBigText.text = data.value(forKey: "ONEINFO_BIGTEXT") as? String ?? "Tiada Maklumat"
        
    }
    
    func updateCellTwoInfo(data: NSDictionary) {
        
        uiivUDTVCTwoInfoIcon.image = UIImage.init(named: data.value(forKey: "TWOINFO_ICONIMAGE") as? String ?? "Tiada Maklumat")
        uilUDTVCTwoInfoBigText.text = data.value(forKey: "TWOINFO_BIGTEXT") as? String ?? "Tiada Maklumat"
        uilUDTVCTwoInfoSubText.text = data.value(forKey: "TWOINFO_SUBTEXT") as? String ?? "Tiada Maklumat"
        
    }

}
