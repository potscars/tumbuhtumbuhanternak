//
//  AplikasiBerkaitanCVC.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 02/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

private struct AplikasiIdentifier {
    
    static let AplikasiCell = "aplikasiCell"
}

class AplikasiBerkaitanCVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureCollectionView()
    }
    
    func configureCollectionView() {
        
        collectionView?.backgroundColor = Colors.backgroundGray
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, (tabBarController?.tabBar.frame.height)!, 0)
    }

    func configureNavigationBar() {
        tabBarItem.title = "Aplikasi Berkaitan"
        navigationItem.title = "Aplikasi Berkaitan"
    }
}

// MARK: UICollectionViewDataSource
extension AplikasiBerkaitanCVC {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AplikasiIdentifier.AplikasiCell, for: indexPath) as! AplikasiCell
        
        return cell
    }
}

// MARK: UICollectionViewDataSource
extension AplikasiBerkaitanCVC : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        let itemWidth = (collectionView.bounds.width - 24) / 2
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
























