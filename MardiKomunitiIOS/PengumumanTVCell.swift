//
//  PengumumanTVCell.swift
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
        
        uiivPVCWPImage.image = UIImage.init(named: "padikebangsaan.jpg")?.resizeImageWith(newSize: CGSize.init(width: 359, height: 145))
        
    }
    
    func updateCell(data: NSDictionary) {
        
        
        
    }

}
