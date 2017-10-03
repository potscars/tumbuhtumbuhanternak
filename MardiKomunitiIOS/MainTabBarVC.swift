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
        configureTabbar()
    }
    
    func configureNavigationBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login", style: .done, target: self, action: #selector(loginButtonTapped(_:)))
    }
    
    func configureTabbar() {
        
        let attributes: [String : Any] = [ NSFontAttributeName: UIFont(name: "Futura-Bold", size: 12.0)!]
        
        for bar in tabBar.items! {
            
            bar.titlePositionAdjustment = UIOffsetMake(0, -(tabBar.frame.height - 12) / 2)
            bar.setTitleTextAttributes(attributes, for: .normal)
        }
    }
    
    @objc private func loginButtonTapped(_ sender : UIBarButtonItem) {
        
        print("Tapped")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var base = appDelegate.window?.rootViewController
        base = self.selectedViewController
        
        if let base = base as? PengumumanTVC {
            base.performSegue(withIdentifier: "GOTO_LOGIN", sender: base)
        }
        
        if let base = base as? AplikasiBerkaitanCVC {
            base.performSegue(withIdentifier: "GOTO_LOGIN", sender: base)
        }
    }
}





