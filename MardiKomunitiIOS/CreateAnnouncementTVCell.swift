//
//  CreateAnnouncementTVCell.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 13/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class CreateAnnouncementTVCell: UITableViewCell {
    
    @IBOutlet weak var uilCATVCSenderName: UILabel!
    @IBOutlet weak var uilCATVCSelectProjLabel: CustomLabel!
    @IBOutlet weak var uitfCATVCSubject: UITextField!
    @IBOutlet weak var uitvCATVCContent: UITextView!
    @IBOutlet weak var uilCATVCImageLoadLabel: UILabel!
    @IBOutlet weak var uivCATVCSelectedImage: UIImageView!
    @IBOutlet weak var uilCATVCNameOfSender: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getNameOfArticleWriter(data: String) {
        uilCATVCSenderName.text = data
    }
    
    func getProjectData(data: String) {
        uilCATVCSelectProjLabel.text = data
    }
    
    func displayImage(data: UIImage) {
        
        uivCATVCSelectedImage.image = data
        
    }

}
