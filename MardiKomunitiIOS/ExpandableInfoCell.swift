//
//  ExpandableInfoCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 16/12/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class ExpandableInfoCell: UITableViewCell {

    @IBOutlet weak var expandedHeaderName: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func updateView(_ headerName: String, content: String = "Tiada maklumat setakat ini.") {
        
        expandedHeaderName.text = headerName
        
        if content != "" {
            contentLabel.text = content
        } else {
            contentLabel.text = "-"
        }
    }
}
