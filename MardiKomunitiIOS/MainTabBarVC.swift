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
        
        /*
        let label = UILabel()
        label.text = Strings.MYA_APP_TITLE
        label.textColor = UIColor.white
        label.textAlignment = .left
        self.navigationItem.titleView = label
        label.translatesAutoresizingMaskIntoConstraints = true
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: label.superview, attribute: .centerX, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: label.superview, attribute: .width, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: label.superview, attribute: .centerY, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: label.superview, attribute: .height, multiplier: 1, constant: 0))
        */

        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login", style: .done, target: self, action: #selector(loginButtonTapped(_:)))
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















