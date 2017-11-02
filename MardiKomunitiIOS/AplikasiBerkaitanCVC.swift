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
    static let HeaderKategori = "headerKategori"
}

class AplikasiBerkaitanCVC: UICollectionViewController {
    
    var alertController = AlertController()
    var aplikasiObject: [(String, UIImage, Int?, String)] = [("MyAgro Fertigasi Tomato", #imageLiteral(resourceName: "fertigasitomato.jpg"), 1055891350, "Tanaman"),
                         ("MyAgro Buah Nadir", #imageLiteral(resourceName: "buahnadir.jpg"), 1179623848, "Tanaman"),
                         ("MyAgro Padi Aerob", #imageLiteral(resourceName: "padiaerob"), 956071438, "Tanaman"),
                         ("MyAgro Dr Cili", #imageLiteral(resourceName: "drcili"), 953004069, "Tanaman"),
                         ("MyAgro Penanaman Jagung Manis", #imageLiteral(resourceName: "myjagung"), 1179621435, "Tanaman"),
                         ("Kelulut", #imageLiteral(resourceName: "kelulut"), 956016090, "Ternakan"),
                         ("MyAgro Cendawan Tiram Kelabu", #imageLiteral(resourceName: "cendawankelabu"), 1055930461, "Tanaman"),
                         ("MyAgro Fertigasi Cili", #imageLiteral(resourceName: "fertigasicili"), 956040261, "Tanaman"),
                         ("MyAgro MyKompos", #imageLiteral(resourceName: "mykompos"), 1179623088, "Tanaman"),
                         ("MyAgro MyPerosak Padi", #imageLiteral(resourceName: "myperosakpadi"), 1179624624, "Tanaman"),
                         ("MyAgro GreenPharmacy", #imageLiteral(resourceName: "greenpharmacy"), 1055909603, "Tanaman"),
                         ("MyAgro Ayam Kampung", #imageLiteral(resourceName: "ayamkampung"), 1055933827, "Ternakan"),
                         ("MyAgro Lembu Brakmas", #imageLiteral(resourceName: "lembubrakmas"), 1179601707, "Ternakan"),
                         ("MyAgro Hidroponik Salad", #imageLiteral(resourceName: "fertigasisalad"), 956040267, "Tanaman"),
                         ("Kambing Pedaging", #imageLiteral(resourceName: "kambingpedaging"), 1055922387, "Ternakan"),
                         ("MyAgro Kalendar Aktiviti Jagung", #imageLiteral(resourceName: "jagungkalendar"), 1179621868, "Tanaman"),
                         ("MyAgro Direktori Pertanian", #imageLiteral(resourceName: "direktoripertanian"), 1231379538, "Tanaman"),
                         ("MyAgro Video", #imageLiteral(resourceName: "video"), 1228027460, "Lain - lain"),
                         ("MyAgro Maklumat Penyakit dan Perosak", #imageLiteral(resourceName: "penyakitperosak"), 1245024622, "Tanaman"),
                         ("MyAgro Maklumat Cuaca", #imageLiteral(resourceName: "cuaca"), 1232145436, "Lain - lain"),
                         ("MyAgro Kalendar Latihan", #imageLiteral(resourceName: "kalendarlatihan"), 1238005041, "Lain - lain"),
                         ("MyAgro Rekod Ladang", #imageLiteral(resourceName: "rekodladang"), 1247783186, "Tanaman"),
                         ("MyAgro Kalendar Komoditi", #imageLiteral(resourceName: "kalendarkomoditi"), nil, "Lain - lain"),
                         ("MyAgro Maklumat Pasaran", #imageLiteral(resourceName: "maklumatpasaran"), 1230894873, "Lain - lain"),
                         ("MyAgro Maklumat Komoditi", #imageLiteral(resourceName: "maklumatkomoditi"), nil, "Lain - lain"),
                         ("MyAgro Kalkulator Aliran Tuai", #imageLiteral(resourceName: "kalkulator"), 1238028973, "Lain - lain"),
                         ("Info Banjir", #imageLiteral(resourceName: "infobanjir"), nil, "Lain - lain"),
                         ("MyHarga Tani", #imageLiteral(resourceName: "myhargatani"), 1100112126, "Lain - lain"),
                         ("Agrimaths", #imageLiteral(resourceName: "opf"), 1221201581, "Lain - lain"),
                         ("eBioSekuriti", #imageLiteral(resourceName: "ebiosekuriti"), 1062734822, "Perikanan"),
                         ("MyAgro 100 Tips Tanaman", #imageLiteral(resourceName: "tipstanaman"), nil, "Tanaman"),
                         ("eLesen Perikanan", #imageLiteral(resourceName: "elesen"), 1059675349, "Perikanan"),
                         ("MyHealth", #imageLiteral(resourceName: "myhealth"), 660740349, "Lain - lain")
    ]
    var tempAplikasiTuple = [(String, UIImage, Int?, String)]()
    var isFiltered = false
    var headerTitle = "Semua Kategori"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Aplikasi Berkaitan"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "X", style: UIBarButtonItemStyle.plain, target: self, action: #selector(closeThisWindow(sender:)))
        
        aplikasiObject = aplikasiObject.sorted(by:{ $0.0 < $1.0 })
        
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
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AplikasiIdentifier.HeaderKategori, for: indexPath)
            headerCell.backgroundColor = .white
            
            let textLabel = headerCell.viewWithTag(1) as! UILabel
            textLabel.isUserInteractionEnabled = true
            
            let tappedTextLabel = UITapGestureRecognizer(target: self, action: #selector(selectCategory(_:)))
            textLabel.addGestureRecognizer(tappedTextLabel)
            headerTextWithImage(headerTitle, textLabel: textLabel)
            
            return headerCell
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func headerTextWithImage(_ headerTitle: String, textLabel: UILabel) {
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = #imageLiteral(resourceName: "ic_arrow_drop_down")
        
        imageAttachment.bounds = CGRect(x: 0, y: -8, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        
        let imageAttachmentString = NSAttributedString(attachment: imageAttachment)
        let textWithImage = NSMutableAttributedString(string: headerTitle)
        textWithImage.append(imageAttachmentString)
        
        textLabel.textColor = .darkGray
        textLabel.attributedText = textWithImage
    }
    
    func selectCategory(_ sender: UIGestureRecognizer) {
        
        let kategoriVC = storyboard?.instantiateViewController(withIdentifier: "AplikasiKategoriVC") as! AplikasiKategoriVC
        kategoriVC.modalPresentationStyle = .overFullScreen
        kategoriVC.delegate = self
        
        present(kategoriVC, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !isFiltered {
            return aplikasiObject.count
        } else {
            return tempAplikasiTuple.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if !isFiltered {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AplikasiIdentifier.AplikasiCell, for: indexPath) as! AplikasiCell
            
            cell.updateCell(aplikasiObject[indexPath.row].0, image: aplikasiObject[indexPath.row].1)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AplikasiIdentifier.AplikasiCell, for: indexPath) as! AplikasiCell
            
            cell.updateCell(tempAplikasiTuple[indexPath.row].0, image: tempAplikasiTuple[indexPath.row].1)
            
            return cell
        }
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
            
            if !isFiltered {
                openURLWithSelectedItem(aplikasiObject[indexPath.row].2)
            } else {
                openURLWithSelectedItem(tempAplikasiTuple[indexPath.row].2)
            }
        }
    }
    
    func openURLWithSelectedItem(_ selectedItemId: Int?) {
        if let id = selectedItemId {
            
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(id)?mt=8"),
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

extension AplikasiBerkaitanCVC: AplikasiKategoriDelegate {
    
    func kategoriSelected(_ kategoriValue: String) {
        
        if kategoriValue == "Semua Kategori" {
            isFiltered = false
        } else {
            isFiltered = true
            tempAplikasiTuple = aplikasiObject.filter{($0.3.contains(kategoriValue))}
        }
        headerTitle = kategoriValue
        collectionView?.reloadData()
    }
}






















