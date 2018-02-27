//
//  PetaniInfoTableViewCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 22/02/2018.
//  Copyright © 2018 com.ingeniworks. All rights reserved.
//

import UIKit

class PetaniInfoTableViewCell: UITableViewCell {
    
    let featuredImageView: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .darkGray
        return iv
    }()
    
    let petaniNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Dwayne The Rock Johnson"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAutoLayout()
    }
    
    let imageHeightConstant: CGFloat = 44.0
    
    private func setupAutoLayout() {
        
        contentView.addSubview(featuredImageView)
        contentView.addSubview(petaniNameLabel)
        
        featuredImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        featuredImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
        featuredImageView.heightAnchor.constraint(equalToConstant: imageHeightConstant).isActive = true
        featuredImageView.widthAnchor.constraint(equalToConstant: imageHeightConstant).isActive = true
        
        petaniNameLabel.centerYAnchor.constraint(equalTo: featuredImageView.centerYAnchor).isActive = true
        petaniNameLabel.leftAnchor.constraint(equalTo: featuredImageView.rightAnchor, constant: 8.0).isActive = true
        petaniNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0).isActive = true
    }
    
    func updateUI(withName name: String) {
        
        petaniNameLabel.text = name
        
        DispatchQueue.main.async {
            self.featuredImageView.circledView(self.featuredImageView.frame.width)
            ZGraphics().createImageWithLetter(name, imageView: self.featuredImageView, fontSize: self.featuredImageView.frame.width / 2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}













