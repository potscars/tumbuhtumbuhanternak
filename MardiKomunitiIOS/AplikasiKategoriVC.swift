//
//  AplikasiKategoriVC.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 02/11/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

protocol AplikasiKategoriDelegate: class {
    
    func kategoriSelected(_ kategoriValue: String)
}

class AplikasiKategoriVC: UIViewController {
    
    @IBOutlet weak var kategoriHolderView: UIView!
    weak var delegate: AplikasiKategoriDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.1) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    @IBAction func kategoriButtonTapped(_ sender: UIButton) {
        if let kategoriValue = sender.titleLabel?.text {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
            }) { (condition) in
                self.delegate?.kategoriSelected(kategoriValue)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        }) { (condition) in
            self.dismiss(animated: true, completion: nil)
        }
    }
}

















