//
//  ErrorCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 11/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class ErrorCell: UITableViewCell {
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var errorMessage: String! {
        didSet {
            errorLabel.text = errorMessage
        }
    }
}
