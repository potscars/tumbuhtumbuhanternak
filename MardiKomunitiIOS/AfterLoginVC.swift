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
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async(execute: {
        
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
            
        })
        
        /*
        label.text = Strings.MYA_APP_TITLE
        label.textColor = UIColor.white
        label.textAlignment = .left
        self.navigationItem.titleView = label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: label.superview, attribute: .centerX, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: label.superview, attribute: .width, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: label.superview, attribute: .centerY, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: label.superview, attribute: .height, multiplier: 1, constant: 0))
         */
        
        configureNavigationBar()
    }
    

    func configureNavigationBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Aplikasi Berkaitan", style: .done, target: self, action: #selector(aplikasiButtonTapped(_:)))
    }
    
    @objc func aplikasiButtonTapped(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: AfterLoginIdentifier.GotoAplikasiBerkaitan, sender: self)
    }
}
