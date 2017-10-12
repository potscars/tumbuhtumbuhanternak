//
//  ProjectMembersCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 11/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class ProjectMembersCell: UITableViewCell {
    
    @IBOutlet weak var featuredImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        featuredImage.circledView(featuredImage.frame.width)
    }
}
