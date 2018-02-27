//
//  ProjectDetailsVC.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 22/02/2018.
//  Copyright © 2018 com.ingeniworks. All rights reserved.
//

import UIKit

class ProjectDetailsVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var projekNameLabel: UILabel!
    @IBOutlet weak var projekCategoryLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var agencyLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuBar: MenuBar!
    
    var aktivitiTV = UITableView()
    var petaniTV = UITableView()
    var pegawaiTV = UITableView()
    
    var sectionHeader = ["Maklumat Aktiviti", "Lokasi"]
    var expandedHeaderName: [(String, Bool)] = [("Sektor", false), ("SubSektor", false), ("Kumpulan Komoditi", false), ("Komuditi", false)]
    var projek: Projek!
    var enrolls: [Enrolls]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        extractedTaxonomyData()
        
        menuBar.menuBarDelegate = self
        
        guard let enrollsTemp = projek.enrolls else { return }
        enrolls = enrollsTemp
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profileImage.circledView(profileImage.frame.width)
        
        projekNameLabel.text = projek.name
        projekCategoryLabel.text = projek.projekCategory
        startDateLabel.text = projek.dateStart != "" ? projek.dateStart : "Tiada Maklumat"
        endDateLabel.text = projek.dateEnd != "" ? projek.dateEnd : "Tiada Maklumat"
        
        var agencyString = ""
        
        for agency in projek.agency! {
            agencyString += agency
        }
        
        agencyLabel.text = agencyString
    }
    
    private func setupCollectionView() {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        
        collectionView.register(MaklumatAktivitiCell.self, forCellWithReuseIdentifier: ProjekIdentifier.MaklumatAktivitiCell)
        collectionView.register(MaklumatPegawaiCell.self, forCellWithReuseIdentifier: ProjekIdentifier.MaklumatPegawaiCell)
        collectionView.register(MaklumatPetaniCell.self, forCellWithReuseIdentifier: ProjekIdentifier.MaklumatPetaniCell)
    }
    
    var sektorInfo = "Tiada Maklumat"
    var subSektorInfo = "Tiada Maklumat"
    var komuditiGroupInfo = "Tiada Maklumat"
    var komuditiInfo = "Tiada Maklumat"
    
    //get data dari [String: Any] untuk enrolls.
    func extractedTaxonomyData() {
        
        if let enlists = projek.enrolls {
            
            for (_, enlist) in enlists.enumerated() {
                
                if let value = enlist.taxonomy!["SEKTOR"] as? String {
                    sektorInfo = "\(value)"
                }
                
                if let value = enlist.taxonomy!["SUB-SEKTOR"] as? String {
                    subSektorInfo = "\(value)"
                }
                
                if let value = enlist.taxonomy!["KUMP KOMUDITI"] as? String {
                    komuditiGroupInfo = "\(value)"
                }
                
                if let value = enlist.taxonomy!["KOMUDITI"] as? String {
                    komuditiInfo = "\(value)"
                }
            }
        }
        
        //buang 2 char last kat string.
        
 /*       if sektorInfo != "Tiada Maklumat" {
            sektorInfo = sektorInfo.substring(to: sektorInfo.index(sektorInfo.endIndex, offsetBy: -2))
        }
        
        if subSektorInfo != "Tiada Maklumat" {
            subSektorInfo = subSektorInfo.substring(to: subSektorInfo.index(subSektorInfo.endIndex, offsetBy: -2))
        }
        
        if komuditiGroupInfo != "Tiada Maklumat" {
            komuditiGroupInfo = komuditiGroupInfo.substring(to: komuditiGroupInfo.index(komuditiGroupInfo.endIndex, offsetBy: -2))
        }
        
        if komuditiInfo != "Tiada Maklumat" {
            komuditiInfo = komuditiInfo.substring(to: komuditiInfo.index(komuditiInfo.endIndex, offsetBy: -2))
        }*/
    }
}

extension ProjectDetailsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.item
        
        if index == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjekIdentifier.MaklumatAktivitiCell, for: indexPath) as! MaklumatAktivitiCell
            
            return cell
        } else if index == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjekIdentifier.MaklumatPegawaiCell, for: indexPath) as! MaklumatPegawaiCell
            
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjekIdentifier.MaklumatPetaniCell, for: indexPath) as! MaklumatPetaniCell
            
            return cell
        }
    }
}

extension ProjectDetailsVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        return self.collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let aktiviCell = cell as? MaklumatAktivitiCell {
            aktivitiTV = aktiviCell.tableview
            aktivitiTV.dataSource = self
            aktivitiTV.delegate = self
            aktivitiTV.reloadData()
        }
        
        if let pegawaiCell = cell as? MaklumatPegawaiCell {
            pegawaiTV = pegawaiCell.tableview
            pegawaiTV.dataSource = self
            pegawaiTV.delegate = self
            pegawaiTV.reloadData()
        }
        
        if let petaniCell = cell as? MaklumatPetaniCell {
            petaniTV = petaniCell.tableview
            petaniTV.dataSource = self
            petaniTV.delegate = self
            petaniTV.reloadData()
        }
    }
    
    //swipe content cell, akan tukar kan menubar title jugak.
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
//        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
//        let cellWidth = layout?.itemSize.width
        
        if scrollView == collectionView {
            let cellWidth = self.collectionView.frame.width
            
            let offset = targetContentOffset.pointee
            let index = (offset.x + collectionView.contentInset.left) / cellWidth
            let roundedIndex = round(index)
            
            menuBar.titleIndex = Int(roundedIndex)
            menuBar.reloadData()
        }
    }
}

extension ProjectDetailsVC: MenuBarDelegate {
    
    func scrollToMenuIndex(toIndex index: Int) {
        
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
}












