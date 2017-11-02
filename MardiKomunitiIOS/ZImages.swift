//
//  ZImages.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/02/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import AVFoundation

class ZImages: NSObject, URLSessionDelegate, URLSessionDataDelegate {

    typealias ImageReturn = (UIImage?,String?)
    typealias ImageArraysReturn = (NSArray?,String?)
    
    var imageURL: String? = nil
    
    override init() { }
    
    static func getImageFromUrlAsync(fromURL: String?, defaultImage: UIImage?) -> UIImage? {
        
        if(fromURL != nil)
        {
            //print("[ZImages] fromURL: \(fromURL!)")
            
            let imageURL: URL = URL.init(string: fromURL!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
            var imageReturn: UIImage? = nil
            
            //print("[ZImages] ImageURL: \(imageURL)")
        
            DispatchQueue.global(qos: .default).async() { () -> Void in
            
                //print("[ZImages] Dispatching queue in global...")
                
                let data: NSData? = NSData.init(contentsOf: imageURL)
                
                //print("[ZImages] Data: \(data)")
            
                DispatchQueue.main.async() { () -> Void in
            
                    imageReturn = UIImage.init(data: data! as Data)

                }
            }
        
            return imageReturn!
        }
        else {
            
            return nil
        }
    }
    
    static func getImageFromUrlSession(fromURL: String, defaultImage: UIImage) -> UIImage {
        
        let imageURL: URL = URL.init(string: fromURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var imageReturn: UIImage = defaultImage
        
        let downloadPicTask = session.dataTask(with: imageURL) { (data, response, error) in
            
            if let e = error {
                print("[ZImages] Error downloading picture, using defaultImage instead : \(e)")
            }
            else {
                
                if (response as? HTTPURLResponse) != nil {
                    
                    if let imageData = data {
                        
                        DispatchQueue.main.async() { () -> Void in
                            
                            let image: UIImage = UIImage.init(data: imageData)!
                            
                            imageReturn = image

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
        
        return imageReturn
    }
    
    func getImageFromURLInArrays(fromURLArrays: NSArray, defaultImage: UIImage, completionHandler: @escaping (ImageArraysReturn) -> ()) {
        
        var imageArrays: NSMutableArray = []
        var errorCount: Int = 0
        var errorCause: [String] = []
        
        if(fromURLArrays != []) {
            
            for i in 0...fromURLArrays.count - 1 {
                
                let imageURLString: String = fromURLArrays.object(at: i) as! String
                let imageURL: URL = URL.init(string: imageURLString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
                let session = URLSession.init(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
                var imageReturn: UIImage = defaultImage
                
                let downloadPicTask = session.dataTask(with: imageURL) { (data, response, error) in
                    
                    if let e = error {
                        errorCause.append("Image \(imageURLString) is \(e.localizedDescription)")
                    }
                    else {
                        
                        if (response as? HTTPURLResponse) != nil {
                            
                            if let imageData = data {
                                
                                DispatchQueue.main.async() { () -> Void in
                                    
                                    let image: UIImage? = UIImage.init(data: imageData)
                                    
                                    if(image != nil) {
                                        
                                        imageReturn = image!
                                        
                                        //print("imagereturn \(imageReturn)")
                                        
                                        imageArrays.add(imageReturn)
                                        
                                        //print("inserted \(imageArrays.count) from \(fromURLArrays.count)")
                                        
                                        if(imageArrays.count == fromURLArrays.count) {
                                            if(errorCount != 0) {
                                                completionHandler((imageArrays,"Error image loads: \(errorCount) \n error cause: \(errorCause)"))
                                            } else {
                                                completionHandler((imageArrays,"No errors found"))
                                            }
                                        }
                                        
                                    }
                                }
                                
                            } else if let e = error {
                                
                                errorCount += 1
                                imageArrays.add(imageReturn)
                                errorCause.append("Image \(imageURLString) is \(e.localizedDescription)")
                                
                                if(imageArrays.count == fromURLArrays.count) {
                                    if(errorCount != 0) {
                                        completionHandler((imageArrays,"Error image loads: \(errorCount) \n error cause: \(errorCause)"))
                                    } else {
                                        completionHandler((imageArrays,"No errors found"))
                                    }
                                }
                                
                            } else {
                                
                                errorCount += 1
                                imageArrays.add(imageReturn)
                                errorCause.append("Image \(imageURLString) is unknown error")
                                
                                if(imageArrays.count == fromURLArrays.count) {
                                    if(errorCount != 0) {
                                        completionHandler((imageArrays,"Error image loads: \(errorCount) \n error cause: \(errorCause)"))
                                    } else {
                                        completionHandler((imageArrays,"No errors found"))
                                    }
                                }
                                
                            }
                            
                        }
                        else if let e = error {
                            
                            errorCount +=  1
                            imageArrays.add(imageReturn)
                            errorCause.append("Image \(imageURLString) is \(e.localizedDescription)")
                            
                            if(imageArrays.count == fromURLArrays.count) {
                                if(errorCount != 0) {
                                    completionHandler((imageArrays,"Error image loads: \(errorCount) \n error cause: \(errorCause)"))
                                } else {
                                    completionHandler((imageArrays,"No errors found"))
                                }
                            }
                            
                        }
                        
                    }
                    
                    
                }
                downloadPicTask.resume()
                
            }
            
        } else {
            
            completionHandler(([],"No URL images provided"))
            
        }
        
        
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print("session finished? \(session)")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("session completed? \(session) with task \(task) and error \(error?.localizedDescription)")
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("session receive data \(session) with datatask \(dataTask) and data \(data)")
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print("Data task response \(session) \\ \(dataTask) \\ \(response)")
    }
    
    func getImageFromUrlSession(fromURL: String, defaultImage: UIImage, completionHandler: @escaping (ImageReturn) -> ()) {
        
        let imageURL: URL = URL.init(string: fromURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var imageReturn: UIImage = defaultImage
        
        let downloadPicTask = session.dataTask(with: imageURL) { (data, response, error) in
            
            if let e = error {
                completionHandler((nil,e.localizedDescription))
            }
            else {
                
                if let res = response as? HTTPURLResponse {
                    
                    if let imageData = data {
                        
                        DispatchQueue.main.async() { () -> Void in
                            
                            let image: UIImage? = UIImage.init(data: imageData)
                            
                            if(image != nil) {
                                
                                imageReturn = image!
                                completionHandler((imageReturn,String.init(describing: res.statusCode)))
                            }
                        }
                        
                    } else if let e = error {
                        
                        completionHandler((defaultImage,e.localizedDescription))
                        
                    } else {
                        
                        completionHandler((defaultImage,"Unknown Error"))
                        
                    }
                    
                }
                else if let e = error {
                    
                    completionHandler((defaultImage,e.localizedDescription))
                    
                }
                
            }
            
            
        }
        downloadPicTask.resume()
        
    }
    
    static func getImageFromUrlSession(fromURL: String, defaultImage: String, imageView: UIImageView, imageViewConstraints: [String:NSLayoutConstraint]?) {
        
        let imageURL: URL = URL.init(string: fromURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let session = URLSession(configuration: URLSessionConfiguration.default)
        imageView.image = UIImage.init(named: defaultImage)!
        
        //print("[ZImages] ImageURL: \(imageURL)")
        
        let downloadPicTask = session.dataTask(with: imageURL) { (data, response, error) in
            
            if let e = error {
                print("[ZImages] Error downloading picture, using defaultImage instead : \(e)")
            }
            else {
                
                if let res = response as? HTTPURLResponse {
                    //print("[ZImages] Response got : \(res.statusCode)")
                    
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
