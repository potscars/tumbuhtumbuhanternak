//
//  ZImages.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/02/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import AVFoundation

class ZImages: NSObject {

    static func getImageFromUrlAsync(fromURL: String?, defaultImage: UIImage?) -> UIImage? {
        
        if(fromURL != nil)
        {
            print("[ZImages] fromURL: \(fromURL!)")
            
            let imageURL: URL = URL.init(string: fromURL!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
            var imageReturn: UIImage? = nil
            
            print("[ZImages] ImageURL: \(imageURL)")
        
            DispatchQueue.global(qos: .default).async() { () -> Void in
            
                print("[ZImages] Dispatching queue in global...")
                
                let data: NSData? = NSData.init(contentsOf: imageURL)
                
                print("[ZImages] Data: \(data)")
            
                DispatchQueue.main.async() { () -> Void in
            
                    imageReturn = UIImage.init(data: data as! Data)

                }
            }
        
            return imageReturn!
        }
        else {
            
            return nil
        }
    }
    
    static func getImageFromUrlSession(fromURL: String, defaultImage: String) -> UIImage {
        
        let imageURL: URL = URL.init(string: fromURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var imageReturn: UIImage = UIImage.init(named: defaultImage)!
            
        let downloadPicTask = session.dataTask(with: imageURL) { (data, response, error) in
            
            if let e = error {
                print("[ZImages] Error downloading picture, using defaultImage instead : \(e)")
            }
            else {
                    
                if let res = response as? HTTPURLResponse {
                    print("[ZImages] Response got : \(res.statusCode)")
                        
                    if let imageData = data {
                            
                        imageReturn = UIImage.init(data: imageData)!
                            
                    } else if let e = error {
                            
                        print("[ZImages] Error processing image, using defaultImage instead : \(e)")
                            
                    } else {
                        
                        print("[ZImages] Unknown error")
                        
                    }
                        
                }
                else if let e = error {
                        
                    print("[ZImages] Error retrieving response, using defaultImage instead : \(e)")
                        
                }
                    
            }
            
            
        }
            
        downloadPicTask.resume()
            
        return imageReturn
    }
    
    
    static func getImageFromUrlSession(fromURL: String, defaultImage: String, imageView: UIImageView, imageViewConstraints: [String:NSLayoutConstraint]?) {
        
        let imageURL: URL = URL.init(string: fromURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let session = URLSession(configuration: URLSessionConfiguration.default)
        imageView.image = UIImage.init(named: defaultImage)!
        
        print("[ZImages] ImageURL: \(imageURL)")
        
        let downloadPicTask = session.dataTask(with: imageURL) { (data, response, error) in
            
            if let e = error {
                print("[ZImages] Error downloading picture, using defaultImage instead : \(e)")
            }
            else {
                
                if let res = response as? HTTPURLResponse {
                    print("[ZImages] Response got : \(res.statusCode)")
                    
                    if let imageData = data {
                        
                        DispatchQueue.main.async() { () -> Void in
                            
                            let image: UIImage = UIImage.init(data: imageData)!//.resizeImageWith(newSize: CGSize.init(width: 359, height: 145))
                            
                            imageView.image = image
                            //imageView.frame = AVMakeRect(aspectRatio: image.size, insideRect: imageView.frame)
                            
                            
                            //let scaleFactor: CGFloat = max(image.size.width/imageView.bounds.size.width, image.size.height/imageView.bounds.size.height)
                            //imageView.frame = CGRect.init(x: 0, y: 0, width: image.size.width/scaleFactor, height: image.size.height/scaleFactor)
                            
                            //imageView.frame = CGRect.init(x: 0, y: 0, width: imageView.frame.width, height: image.size.height)
                            //imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: image.size.width / image.size.height).isActive = true
                            /*
                            if(imageViewConstraints != nil)
                            {
                                let widthLayoutConstraint: NSLayoutConstraint = imageViewConstraints!["CONSTRAINT_WIDTH"]!
                                let heightLayoutConstraint: NSLayoutConstraint = imageViewConstraints!["CONSTRAINT_HEIGHT"]!
                                
                                if imageView.frame.size.width < imageView.image!.size.width {
                                
                                    print("Resizing Width Frame...")
                                    
                                    heightLayoutConstraint.constant = imageView.frame.size.width / (imageView.image!.size.width) * (imageView.image!.size.height)
                                
                                }
                                
                                if imageView.frame.size.height < imageView.image!.size.height {
                                    
                                    print("Resizing Height Frame...")
                                    
                                    widthLayoutConstraint.constant = imageView.frame.size.height / (imageView.image!.size.height) * (imageView.image!.size.height)
                                    
                                    //widthLayoutConstraint.constant = -100
                                    
                                }
                                imageView.setNeedsUpdateConstraints()
                            }
                            */
                            
                        }
                        
                    } else if let e = error {
                        
                        print("[ZImages] Error processing image, using defaultImage instead : \(e)")
                        
                    } else {
                        
                        print("[ZImages] Unknown error")
                        
                    }
                    
                }
                else if let e = error {
                    
                    print("[ZImages] Error retrieving response, using defaultImage instead : \(e)")
                    
                }
                
            }
            
            
        }
        
        downloadPicTask.resume()
    }
    
    
}
