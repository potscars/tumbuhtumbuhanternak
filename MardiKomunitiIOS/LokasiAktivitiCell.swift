//
//  LokasiAktivitiCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 22/02/2018.
//  Copyright © 2018 com.ingeniworks. All rights reserved.
//

import UIKit

class LokasiAktivitiCell: UITableViewCell {
    
    let locationImageView: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "ic_location_on")
        iv.tintColor = .darkGray
        iv.clipsToBounds = true
        return iv
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Tiada maklumat"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightRegular)
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupAutoLayout()
    }
    
    let imageHeightConstant: CGFloat = 24.0
    
    private func setupAutoLayout() {
        
        contentView.addSubview(locationImageView)
        contentView.addSubview(locationLabel)
        
        locationImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        locationImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
        locationImageView.heightAnchor.constraint(equalToConstant: imageHeightConstant).isActive = true
        locationImageView.widthAnchor.constraint(equalToConstant: imageHeightConstant).isActive = true
        
        locationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: locationImageView.rightAnchor, constant: 8.0).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
