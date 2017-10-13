//
//  AfterLoginVC.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 05/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

struct AfterLoginIdentifier {
    
    static let GotoAplikasiBerkaitan = "GOTO_APLIKASIBERKAITAN"
}

class AfterLoginVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async(execute: {
        
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
            
        })
        
        configureNavigationBar()
    }

    func configureNavigationBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Aplikasi Berkaitan", style: .done, target: self, action: #selector(aplikasiButtonTapped(_:)))
    }
    
    @objc func aplikasiButtonTapped(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: AfterLoginIdentifier.GotoAplikasiBerkaitan, sender: self)
    }
}
