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
    
    let aplikasiObject = [("MyAgro Fertigasi Tomato", #imageLiteral(resourceName: "fertigasitomato.jpg")),
                         ("MyAgro Buah Nadir", #imageLiteral(resourceName: "buahnadir.jpg")),
                         ("MyAgro Padi Aerob", #imageLiteral(resourceName: "padiaerob")),
                         ("MyAgro Dr Cili", #imageLiteral(resourceName: "drcili")),
                         ("MyAgro Penanaman Jagung Manis", #imageLiteral(resourceName: "myjagung")),
                         ("Kelulut", #imageLiteral(resourceName: "kelulut")),
                         ("MyAgro Cendawan Tiram Kelabu", #imageLiteral(resourceName: "cendawankelabu")),
                         ("MyAgro Fertigasi Cili", #imageLiteral(resourceName: "fertigasicili")),
                         ("MyAgro MyKompos", #imageLiteral(resourceName: "mykompos")),
                         ("MyAgro MyPerosak Padi", #imageLiteral(resourceName: "myperosakpadi")),
                         ("MyAgro GreenPharmacy", #imageLiteral(resourceName: "greenpharmacy")),
                         ("MyAgro Ayam Kampung", #imageLiteral(resourceName: "ayamkampung")),
                         ("MyAgro Lembu Brakmas", #imageLiteral(resourceName: "lembubrakmas")),
                         ("MyAgro Hidroponik Salad", #imageLiteral(resourceName: "fertigasisalad")),
                         ("Kambing Pedaging", #imageLiteral(resourceName: "kambingpedaging")),
                         ("MyAgro Kalendar Aktiviti Jagung", #imageLiteral(resourceName: "jagungkalendar")),
                         ("MyAgro Direktori Pertanian", #imageLiteral(resourceName: "direktoripertanian")),
                         ("MyAgro Video", #imageLiteral(resourceName: "video")),
                         ("MyAgro Maklumat Penyakit dan Perosak", #imageLiteral(resourceName: "penyakitperosak")),
                         ("MyAgro Maklumat Cuaca", #imageLiteral(resourceName: "cuaca")),
                         ("MyAgro Kalendar Latihan", #imageLiteral(resourceName: "kalendarlatihan")),
                         ("MyAgro Rekod Ladang", #imageLiteral(resourceName: "rekodladang")),
                         ("MyAgro Kalendar Komoditi", #imageLiteral(resourceName: "kalendarkomoditi")),
                         ("MyAgro Maklumat Pasaran", #imageLiteral(resourceName: "maklumatpasaran")),
                         ("MyAgro Maklumat Komoditi", #imageLiteral(resourceName: "maklumatkomoditi")),
                         ("MyAgro Kalkulator Aliran Tuai", #imageLiteral(resourceName: "kalkulator")),
                         ("Info Banjir", #imageLiteral(resourceName: "infobanjir")),
                         ("MyHarga Tani", #imageLiteral(resourceName: "myhargatani")),
                         ("Agrimaths", #imageLiteral(resourceName: "opf")),
                         ("eBioSekuriti", #imageLiteral(resourceName: "ebiosekuriti")),
                         ("MyAgro 100 Tips Tanaman", #imageLiteral(resourceName: "tipstanaman")),
                         ("eLesen Perikanan", #imageLiteral(resourceName: "elesen")),
                         ("MyHealth", #imageLiteral(resourceName: "myhealth"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configureNavigationBar()
        configureCollectionView()
    }
    
    func configureCollectionView() {
        
        collectionView?.backgroundColor = Colors.backgroundGray
        collectionView?.showsVerticalScrollIndicator = false
        
        if let bottomBarHeight = tabBarController?.tabBar.frame.height {
            collectionView?.contentInset = UIEdgeInsetsMake(0, 0, bottomBarHeight, 0)
        }
    }

    func configureNavigationBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil)
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
        return aplikasiObject.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AplikasiIdentifier.AplikasiCell, for: indexPath) as! AplikasiCell
        
        cell.updateCell(aplikasiObject[indexPath.row].0, image: aplikasiObject[indexPath.row].1)
        
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
    
    func getNameLabelHeight(_ name: String, width: CGFloat) -> CGFloat {
        
        let tempLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width - 16, height: CGFloat.greatestFiniteMagnitude))
        tempLabel.numberOfLines = 0
        tempLabel.text = name
        tempLabel.sizeToFit()
        return tempLabel.frame.height
    }
}
























