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
    
    var alertController = AlertController()
    let aplikasiObject: [(String, UIImage, Int?)] = [("MyAgro Fertigasi Tomato", #imageLiteral(resourceName: "fertigasitomato.jpg"), 1055891350),
                         ("MyAgro Buah Nadir", #imageLiteral(resourceName: "buahnadir.jpg"), 1179623848),
                         ("MyAgro Padi Aerob", #imageLiteral(resourceName: "padiaerob"), 956071438),
                         ("MyAgro Dr Cili", #imageLiteral(resourceName: "drcili"), 953004069),
                         ("MyAgro Penanaman Jagung Manis", #imageLiteral(resourceName: "myjagung"), 1179621435),
                         ("Kelulut", #imageLiteral(resourceName: "kelulut"), 956016090),
                         ("MyAgro Cendawan Tiram Kelabu", #imageLiteral(resourceName: "cendawankelabu"), 1055930461),
                         ("MyAgro Fertigasi Cili", #imageLiteral(resourceName: "fertigasicili"), 956040261),
                         ("MyAgro MyKompos", #imageLiteral(resourceName: "mykompos"), 1179623088),
                         ("MyAgro MyPerosak Padi", #imageLiteral(resourceName: "myperosakpadi"), 1179624624),
                         ("MyAgro GreenPharmacy", #imageLiteral(resourceName: "greenpharmacy"), 1055909603),
                         ("MyAgro Ayam Kampung", #imageLiteral(resourceName: "ayamkampung"), 1055933827),
                         ("MyAgro Lembu Brakmas", #imageLiteral(resourceName: "lembubrakmas"), 1179601707),
                         ("MyAgro Hidroponik Salad", #imageLiteral(resourceName: "fertigasisalad"), 956040267),
                         ("Kambing Pedaging", #imageLiteral(resourceName: "kambingpedaging"), 1055922387),
                         ("MyAgro Kalendar Aktiviti Jagung", #imageLiteral(resourceName: "jagungkalendar"), 1179621868),
                         ("MyAgro Direktori Pertanian", #imageLiteral(resourceName: "direktoripertanian"), 1231379538),
                         ("MyAgro Video", #imageLiteral(resourceName: "video"), 1228027460),
                         ("MyAgro Maklumat Penyakit dan Perosak", #imageLiteral(resourceName: "penyakitperosak"), 1245024622),
                         ("MyAgro Maklumat Cuaca", #imageLiteral(resourceName: "cuaca"), 1232145436),
                         ("MyAgro Kalendar Latihan", #imageLiteral(resourceName: "kalendarlatihan"), 1238005041),
                         ("MyAgro Rekod Ladang", #imageLiteral(resourceName: "rekodladang"), 1247783186),
                         ("MyAgro Kalendar Komoditi", #imageLiteral(resourceName: "kalendarkomoditi"), nil),
                         ("MyAgro Maklumat Pasaran", #imageLiteral(resourceName: "maklumatpasaran"), 1230894873),
                         ("MyAgro Maklumat Komoditi", #imageLiteral(resourceName: "maklumatkomoditi"), nil),
                         ("MyAgro Kalkulator Aliran Tuai", #imageLiteral(resourceName: "kalkulator"), 1238028973),
                         ("Info Banjir", #imageLiteral(resourceName: "infobanjir"), nil),
                         ("MyHarga Tani", #imageLiteral(resourceName: "myhargatani"), 1100112126),
                         ("Agrimaths", #imageLiteral(resourceName: "opf"), 1221201581),
                         ("eBioSekuriti", #imageLiteral(resourceName: "ebiosekuriti"), 1062734822),
                         ("MyAgro 100 Tips Tanaman", #imageLiteral(resourceName: "tipstanaman"), nil),
                         ("eLesen Perikanan", #imageLiteral(resourceName: "elesen"), 1059675349),
                         ("MyHealth", #imageLiteral(resourceName: "myhealth"), 660740349)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Aplikasi Berkaitan"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "X", style: UIBarButtonItemStyle.plain, target: self, action: #selector(closeThisWindow(sender:)))
        
        //configureNavigationBar()
        configureCollectionView()
    }
    
    func closeThisWindow(sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
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

// MARK: UICollectionViewDelegate
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let _ = collectionView.cellForItem(at: indexPath) {
            
            if let aplikasiID = aplikasiObject[indexPath.row].2 {
                
                if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(aplikasiID)?mt=8"),
                    UIApplication.shared.canOpenURL(url)
                {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            } else {
                alertController.alertController(self, title: "Gagal", message: "Aplikasi ini tiada di dalam AppStore.")
            }
        }
    }
}
























