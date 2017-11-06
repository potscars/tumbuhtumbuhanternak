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
    @IBOutlet weak var uilPDTVCArticleFirstName: UILabel!
    
    
    @IBOutlet weak var uiivPDTVCArticleImageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var uiivPDTVCArticleImageHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateSenderInfo(data: NSDictionary) {
        
        var senderName: String? = nil
        var senderDate: String? = nil
        
        if data.value(forKey: "name") is NSNull { senderName = "Tiada Data" } else { senderName = data.value(forKey: "name") as? String }
        
        if data.value(forKey: "created_at") is NSNull { senderDate = "1970-01-01 00:00:00" } else { senderDate = data.value(forKey: "created_at") as? String }
        
        uilPDTVCSenderName.text = senderName!
        uilPDTVCArticleFirstName.text = senderName![0]
        uilPDTVCArticleFirstName.textColor = UIColor.white
        uilPDTVCArticleFirstName.layer.backgroundColor = UIColor.purple.cgColor
        uilPDTVCArticleFirstName.layer.cornerRadius = 27
        uilPDTVCSenderDate.text = DateComponents.dateFormatConverter(valueInString: String.checkStringValidity(data: senderDate, defaultValue: "1970-01-01 00:00:00"), dateTimeFormatFrom: nil, dateTimeFormatTo: DateComponents.DateInLong)
        
    }
    
    func updateSenderImage(data: NSArray, tableView: UITableView, indexPath: IndexPath) {
            
        let getFirstImageDict: NSDictionary = data.object(at: indexPath.row) as! NSDictionary
        let getFirstImageString: String = String.checkStringValidity(data: getFirstImageDict.value(forKey: "name"), defaultValue: "ic_default.png")
        let getFirstImage: String =  String.init(format: "%@%@", URLs.loadImage, getFirstImageString)
            
        self.uiivPDTVCArticleImage.image = #imageLiteral(resourceName: "ic_default.png")
        let loadImageToURL: URL = URL.init(string: getFirstImage)!
        self.uiivPDTVCArticleImage.kf.setImage(with: loadImageToURL, placeholder: #imageLiteral(resourceName: "ic_default.png"))
    }
    
    func updateDescriptions(data: NSDictionary) {
        
        uilPDTVCArticleFullDesc.text = String.init(format: "%@", data.value(forKey: "ARTICLE_CONTENT") as? String ?? "Data Tiada")
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad { uilPDTVCArticleFullDesc.font = UIFont.systemFont(ofSize: 20.0) }
        
    }
    
}
