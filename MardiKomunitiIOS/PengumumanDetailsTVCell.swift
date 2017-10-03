//
//  PengumumanDetailsTVCell.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

extension UIImage{
    
    func resizeImageWith(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
}

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

    func updateSenderInfo(data: NSDictionary) {
        
        uilPDTVCSenderName.text = ""
        uilPDTVCSenderDate.text = ""
        
    }
    
    func updateSenderImage(data: NSDictionary) {
        
        uiivPDTVCArticleImage.image = UIImage.init(named: "")
        
    }
    
    func updateDescriptions(data: NSDictionary) {
        
        uilPDTVCArticleFullDesc.text = "Padi merupakan tanaman strategik dari segi keselamatan makanan, pembasmian kemiskinan dan sosio-politik di Malaysia."
        
    }
    
}
