//
//  MainTabBarVC.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 02/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login", style: .done, target: self, action: #selector(loginButtonTapped(_:)))
    }
    
    @objc private func loginButtonTapped(_ sender : UIBarButtonItem) {
        
        print("Tapped")
    }
}