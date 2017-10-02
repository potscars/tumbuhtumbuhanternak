//
//  Extension.swift
//  DBPrototype
//
//  Created by Hainizam on 20/09/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        layer.shadowRadius = 2.5
        layer.shadowOffset = CGSize(width: -1, height: -1)
        layer.shadowOpacity = 0.7
        layer.shadowColor = UIColor.black.cgColor
    }
    
    func roundedCorners(_ roundedValue: CGFloat) {
        
        layer.cornerRadius = roundedValue
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UIColor {
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
