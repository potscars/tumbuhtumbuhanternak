//
//  PengumumanTVCell.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Kingfisher

class PengumumanTVCell: UITableViewCell {

    @IBOutlet weak var uivPVCNPBackGround: CustomView!
    @IBOutlet weak var uilPVCNPTitle: UILabel!
    @IBOutlet weak var uilPVCNPDesc: UILabel!
    
    
    @IBOutlet weak var uivPVCWPBackGround: CustomView!
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
    
    func updateImageCell(data: NSDictionary, tableView: UITableView, indexPath: IndexPath) {
        
        let getFirstImageArray: NSArray = data.value(forKey: "ARTICLE_IMAGE") as! NSArray
        let getFirstImageDict: NSDictionary = getFirstImageArray.object(at: 0) as! NSDictionary
        let getFirstImageString: String = String.checkStringValidity(data: getFirstImageDict.value(forKey: "name"), defaultValue: "ic_default.png")
        //let getFirstImage: String =  String.init(format: "%@%@", URLs.loadImage, getFirstImageString) // original
        let getFirstImage: String =  String.init(format: "%@", getFirstImageString)
        let loadImageToURL: URL = URL.init(string: getFirstImage)!
        self.uiivPVCWPImage.kf.setImage(with: loadImageToURL, placeholder: #imageLiteral(resourceName: "ic_default.png"))
        print("imageurl: \(loadImageToURL)")
        
        
        //uiivPVCWPImage.image = getFirstCachedImage
        uilPVCWPTitle.text = String.checkStringValidity(data: data.value(forKey: "ARTICLE_TITLE"), defaultValue: "Data Kosong")
        uilPVCWPDesc.text = String.checkStringValidity(data: data.value(forKey: "ARTICLE_CONTENT"), defaultValue: "Data Kosong")
        //uivPVCWPBackGround.layer.backgroundColor = UIColor.init(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0).cgColor
        uivPVCWPBackGround.layer.cornerRadius = 3.0
        //uivPVCWPBackGround.defaultDropShadow(scale: true)
    }
    
    func updateCell(data: NSDictionary) {
        
        //uivPVCNPBackGround.layer.backgroundColor = UIColor.init(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0).cgColor
        //uivPVCNPBackGround.defaultDropShadow()
        uivPVCNPBackGround.layer.cornerRadius = 3.0
        uilPVCNPTitle.text = String.checkStringValidity(data: data.value(forKey: "ARTICLE_TITLE"), defaultValue: "Data Kosong")
        uilPVCNPDesc.text = String.checkStringValidity(data: data.value(forKey: "ARTICLE_CONTENT"), defaultValue: "Data Kosong")
        
    }
    
    func updateLoadingCell(cellIdentifier: PengumumanTVCell) {
        
        let xAxis = cellIdentifier.center.x
        let yAxis = cellIdentifier.center.y
        let setLoadingFrame = CGRect.init(x: xAxis - 100, y: yAxis - 20, width: 40, height: 40)
        let setTextFrame = CGRect.init(x: xAxis - 60, y: yAxis - 15, width: 200, height: 40)
        let nvIndicator: NVActivityIndicatorView = NVActivityIndicatorView.init(frame: setLoadingFrame, type: .ballPulse, color: UIColor.init(red: 6.0/255.0, green: 142.0/255.0, blue: 61.0/255.0, alpha: 1), padding: nil)
        let textView: UITextView = UITextView.init(frame: setTextFrame)
        textView.text = "Sedang memuatkan..."
        
        cellIdentifier.addSubview(nvIndicator)
        cellIdentifier.addSubview(textView)
        nvIndicator.startAnimating()
        
    }

}
