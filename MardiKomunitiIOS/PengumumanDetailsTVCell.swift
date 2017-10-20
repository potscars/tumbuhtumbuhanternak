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
        
        uilPDTVCSenderName.text = ""
        uilPDTVCSenderDate.text = ""
        
    }
    
    func updateSenderImage(data: NSArray, tableView: UITableView) {
        
        //let getFirstImageArray: NSArray = data.value(forKey: "ARTICLE_IMAGE") as! NSArray
        
        for i in 0...data.count - 1 {
            
            let getFirstImageDict: NSDictionary = data.object(at: i) as! NSDictionary
            let getFirstImageString: String = String.checkStringValidity(data: getFirstImageDict.value(forKey: "name"), defaultValue: "ic_default.png")
            let getFirstImage: String =  String.init(format: "%@%@", URLs.loadImage, getFirstImageString)
            
            tableView.beginUpdates()
            ZImages.getImageFromUrlSession(fromURL: getFirstImage, defaultImage: "ic_default.png", imageView: uiivPDTVCArticleImage, imageViewConstraints: nil)
            tableView.endUpdates()
            
        }
        
        
        
    }
    
    func updateDescriptions(data: NSDictionary) {
        
        uilPDTVCArticleFullDesc.text = "Padi merupakan tanaman strategik dari segi keselamatan makanan, pembasmian kemiskinan dan sosio-politik di Malaysia."
        
    }
    
}
