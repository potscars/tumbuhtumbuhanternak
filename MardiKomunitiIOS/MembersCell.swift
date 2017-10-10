//
//  MembersCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 04/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class MembersCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.showsHorizontalScrollIndicator = false
        
        let nibName = UINib(nibName: "MembersCollectionCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: MessageIdentifier.MessageMemberCollectionCell)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}




















