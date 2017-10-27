//
//  PengumumanData.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 25/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class PengumumanData: NSObject {

    static var np: NetworkProcessor? = nil
    
    static func nonLoggedInData(tableView: UITableView, refreshControl: UIRefreshControl?) -> NSArray {
        
        let dataArray: NSMutableArray = []
        np = NetworkProcessor.init(URLs.guestAnnouncementURL)
        np!.getRequestJSONFromUrl  { (result, response) in
            
            if result is NSDictionary {
                
                let convertData: NSDictionary = result as! NSDictionary
                let grabDataDict: NSDictionary = convertData.value(forKey: "data") as! NSDictionary
                let grabFullDataArray: NSArray = grabDataDict.value(forKey: "data") as! NSArray

                for i in 0...grabFullDataArray.count - 1 {
                    
                    let grabData: NSDictionary = grabFullDataArray.object(at: i) as! NSDictionary
                    let getImageArray: NSArray? = grabData.value(forKey: "images") as? NSArray
                    
                    dataArray.add([
                        "ARTICLE_TITLE":String.checkStringValidity(data: grabData.value(forKey: "title"), defaultValue: "Data Kosong"),
                        "ARTICLE_CONTENT":String.checkStringValidity(data: grabData.value(forKey: "content"), defaultValue: "Data Kosong"),
                        "ARTICLE_IMAGE":getImageArray ?? [],
                        "ARTICLE_SENDER": grabData.value(forKey: "user")
                        ])
                    
                }
                
                DispatchQueue.main.async {
                    
                    tableView.reloadData()
                    if refreshControl != nil { refreshControl!.endRefreshing() }
                    
                }
                
                
            } else if result is NSArray {
                
                
            } else {
                
                
            }
            
            
        }
        return dataArray
    }
    
    static func loggedInData(tableView: UITableView, refreshControl: UIRefreshControl?) -> NSArray {
        
        let dataArray: NSMutableArray = []
        np = NetworkProcessor.init(URLs.loggedAnnouncementURL)
        np!.postRequestJSONFromUrl(["token":UserDefaults.standard.object(forKey: "MYA_USERTOKEN") as! String]) { (result, response) in
            
            if result != nil {
                
                let convertData: NSDictionary = result! as NSDictionary
                
                guard let status = convertData.value(forKey: "status") as? Int, status == 1 else {
                    return
                }
                
                let grabDataDict: NSDictionary = convertData.value(forKey: "data") as! NSDictionary
                let grabFullDataArray: NSArray = grabDataDict.value(forKey: "data") as! NSArray
                
                for i in 0...grabFullDataArray.count - 1 {
                    
                    let grabData: NSDictionary = grabFullDataArray.object(at: i) as! NSDictionary
                    let getImageArray: NSArray? = grabData.value(forKey: "images") as? NSArray
                    
                    dataArray.add([
                        "ARTICLE_TITLE":String.checkStringValidity(data: grabData.value(forKey: "title"), defaultValue: "Data Kosong"),
                        "ARTICLE_CONTENT":String.checkStringValidity(data: grabData.value(forKey: "content"), defaultValue: "Data Kosong"),
                        "ARTICLE_IMAGE":getImageArray ?? [],
                        "ARTICLE_SENDER": grabData.value(forKey: "user")
                        ])
                    
                }
                
                DispatchQueue.main.async {
                    
                    tableView.reloadData()
                    if refreshControl != nil { refreshControl!.endRefreshing() }
                    
                }
                
            }
        }
        return dataArray
    }
    
}
