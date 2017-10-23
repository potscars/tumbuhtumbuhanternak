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
        
        let titleLabel = UILabel()
        titleLabel.text = "MYAgro"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Futura-Bold", size: 14.0)!
        titleLabel.sizeToFit()
        
        
        let nameLabel = UILabel()
        
        if let username = UserDefaults.standard.object(forKey: "MYA_USERNAME") as? String {
            nameLabel.text = username
        } else {
            nameLabel.text = "Guest007"
        }
        
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "Futura", size: 10.0)!
        nameLabel.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, nameLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.frame.size.width = 100
        stackView.frame.size.height = titleLabel.frame.height + nameLabel.frame.height
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: stackView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Aplikasi Berkaitan", style: .done, target: self, action: #selector(aplikasiButtonTapped(_:)))
    }
    
    @objc func aplikasiButtonTapped(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: AfterLoginIdentifier.GotoAplikasiBerkaitan, sender: self)
    }
}
