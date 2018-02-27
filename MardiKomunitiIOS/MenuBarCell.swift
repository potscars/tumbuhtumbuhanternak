//
//  MenuBarCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 22/02/2018.
//  Copyright © 2018 com.ingeniworks. All rights reserved.
//

import UIKit

class MenuBarCell: UICollectionViewCell {
    
    var menuTitle: String! {
        didSet {
            titleLabel.text = menuTitle
        }
    }
    
    var titleColor: UIColor! {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    let titleLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        label.textColor = .white
        label.text = "Freeze"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        
        addSubview(titleLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8.0).isActive = true
        //titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







