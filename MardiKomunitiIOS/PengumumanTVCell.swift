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
    
    func updateImageCell(data: NSDictionary) {
        
        let getFirstImageArray: NSArray = data.value(forKey: "ARTICLE_IMAGE") as! NSArray
        let getFirstImageDict: NSDictionary = getFirstImageArray.object(at: 0) as! NSDictionary
        let getFirstImageString: String = String.checkStringValidity(data: getFirstImageDict.value(forKey: "name"), defaultValue: "ic_default.png")
        let getFirstImage: String =  String.init(format: "%@%@", URLs.loadImage, getFirstImageString)
        
        ZImages.getImageFromUrlSession(fromURL: getFirstImage, defaultImage: "ic_default.png", imageView: uiivPVCWPImage)
        uilPVCWPTitle.text = String.checkStringValidity(data: data.value(forKey: "ARTICLE_TITLE"), defaultValue: "Data Kosong")
        uilPVCWPDesc.text = String.checkStringValidity(data: data.value(forKey: "ARTICLE_CONTENT"), defaultValue: "Data Kosong")
        
    }
    
    func updateCell(data: NSDictionary) {
        
        uilPVCNPTitle.text = String.checkStringValidity(data: data.value(forKey: "ARTICLE_TITLE"), defaultValue: "Data Kosong")
        uilPVCNPDesc.text = String.checkStringValidity(data: data.value(forKey: "ARTICLE_CONTENT"), defaultValue: "Data Kosong")
        
    }

}
