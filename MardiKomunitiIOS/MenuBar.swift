//
//  MenuBar.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 22/02/2018.
//  Copyright © 2018 com.ingeniworks. All rights reserved.
//

import UIKit

protocol MenuBarDelegate {
    func scrollToMenuIndex(toIndex index: Int)
}

class MenuBar: UICollectionView, UICollectionViewDelegateFlowLayout {
    
    let menuTitles: [String] = ["Maklumat Aktiviti", "Maklumat Pegawai", "Maklumat Petani"]
    var menuBarDelegate: MenuBarDelegate?
    var titleIndex = 0
    
    override func awakeFromNib() {
        dataSource = self
        delegate = self
        backgroundColor = Colors.mainGreen
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        
        register(MenuBarCell.self, forCellWithReuseIdentifier: "menuBarCell")
    }
}

extension MenuBar: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuBarCell", for: indexPath) as! MenuBarCell
        
        let titleColor = indexPath.row == titleIndex ? UIColor.white : UIColor.lightGray
        
        cell.menuTitle = menuTitles[indexPath.item]
        cell.titleColor = titleColor
        
        return cell
    }
}

extension MenuBar: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)

        let height = frame.height
        let width = collectionView.frame.width / CGFloat(menuTitles.count)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedIndex = indexPath.row
        
        for (key, _) in menuTitles.enumerated() {
            let indexPath = IndexPath(row: key, section: 0)
            let cell = collectionView.cellForItem(at: indexPath) as! MenuBarCell
            
            let titleColor: UIColor = key == selectedIndex ? .white : .lightGray
            cell.titleColor = titleColor
        }
        
        self.menuBarDelegate?.scrollToMenuIndex(toIndex: selectedIndex)
    }
}




