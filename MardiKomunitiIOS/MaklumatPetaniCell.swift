//
//  MaklumatPetaniCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 22/02/2018.
//  Copyright © 2018 com.ingeniworks. All rights reserved.
//

import UIKit

class MaklumatPetaniCell: UICollectionViewCell {
    
    lazy var tableview: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(PetaniInfoTableViewCell.self, forCellReuseIdentifier: ProjekIdentifier.PetaniTableViewCell)
        let errorNib = UINib(nibName: "ErrorCell", bundle: nil)
        tableView.register(errorNib, forCellReuseIdentifier: MessageIdentifier.ErrorCell)
        tableView.autoresizesSubviews = true
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("CollectionView Size: ", frame.size)
        
        backgroundColor = .blue
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        
        contentView.addSubview(tableview)
        
        tableview.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tableview.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        tableview.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}














