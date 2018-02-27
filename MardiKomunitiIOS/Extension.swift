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
    
    func circledView(_ widthView: CGFloat) {
        
        layer.cornerRadius = widthView / 2
        layer.masksToBounds = true
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
    
    static let smoothGreen = UIColor.rgb(red: 130, green: 224, blue: 170)
    static let customDarkGray = UIColor.rgb(red: 93, green: 109, blue: 126)
    static let customLightGray = UIColor.rgb(red: 191, green: 201, blue: 202)
    static let darkBlue = UIColor.init(red: 21/255, green: 67/255, blue: 96/255, alpha: 1)
    static let lightBlue = UIColor.init(red: 93/255, green: 173/255, blue: 226/255, alpha: 1)
    static let lightRed = UIColor.rgb(red: 255, green: 52, blue: 52)
    static let lightOrange = UIColor.rgb(red: 255, green: 175, blue: 52)
    static let lightYellow = UIColor.rgb(red: 249, green: 255, blue: 52)
    static let lightPurple = UIColor.rgb(red: 155, green: 89, blue: 182)
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension String {
    
    func getStringSize(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size
    }
}

extension Array {
    
    func filterDuplicates(includeElement: @escaping (_ lhs: Element, _ rhs: Element) -> Bool) -> [Element] {
        
        var results = [Element]()
        
        forEach { (element) in
            
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        return results
    }
}









