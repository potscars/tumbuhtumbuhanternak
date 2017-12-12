//
//  Engages.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 11/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class Respond {
    
    var responderName: String?
    var responderMessage: String?
    var responderCaption: String?
    var responderPostedDate: String?
    var conversationPostedDate: String?
    
    init (_ responderName: String, responderMessage: String, responderCaption: String, responderPostedDate: String, conversationPostedDate: String) {
        
        self.responderName = responderName
        self.responderMessage = responderMessage
        self.responderCaption = responderCaption
        self.responderPostedDate = responderPostedDate
        self.conversationPostedDate = conversationPostedDate
    }
    
    init() {
        
    }
    
    func fetchData(_ conversationId: Int, completion: @escaping (([Respond]?,_ respondersName: [String]? , String?) -> ())) {
        
        let networkProcessor = NetworkProcessor.init("\(URLs.listConversationURL)/\(conversationId)")
        let token = UserDefaults.standard.object(forKey: "MYA_USERTOKEN")
        let params: [String : Any] = ["token" : token ?? ""]
        
        networkProcessor.postRequestJSONFromUrl(params) { (results, responses) in
            
            guard responses == nil else {
                completion(nil, nil, responses)
                return;
            }
            guard let status = results?["status"] as? Int else { return; }
            
            if status == 1 {
                
                var respondTemp = [Respond]()
                
                var enNameTemp = "Rocky Balboa"
                var resNameTemp = "Kim Byung Man"
                var resMessageTemp: String?
                var resCaptionTemp: String? = "Tiada data."
                var resPostedDateTemp: String?
                var conPostedDateTemp: String?
                var resNamesTemp = [String]()
                
                guard let resultsData = results?["data"] as? NSArray, resultsData.count > 0 else {
                    completion(nil, nil, "No data available")
                    return;
                }
                
                for resultData in resultsData {
                    
                    
                    if let conPostedDate = (resultData as AnyObject).value(forKey: "created_at") as? String {
                        conPostedDateTemp = conPostedDate
                    }
                    
                    guard let engages = (resultData as AnyObject).value(forKey: "engages") as? NSArray, engages.count > 0 else { return; }
                    
                    for engage in engages {
                        if let user = (engage as AnyObject).value(forKey: "user") as? NSDictionary, let engageName = user["name"] as? String {
                            enNameTemp = engageName
                            resNamesTemp.append(engageName)
                        }
                    }
                    
                    guard let responds = (resultData as AnyObject).value(forKey: "responds") as? NSArray else { return; }
                    
                    for respond in responds {
                        
                        if let resMessage = (respond as AnyObject).value(forKey: "message") as? String {
                            resMessageTemp = resMessage
                            
                        }
                        
                        if let resPostedDate = (respond as AnyObject).value(forKey: "created_at") as? String {
                            resPostedDateTemp = resPostedDate
                        }
                        
                        if let engage = (respond as AnyObject).value(forKey: "engage") as? NSDictionary, let user = engage["user"] as? NSDictionary {
                            
                            if let name = user["name"] as? String {
                                resNameTemp = name
                                if name != enNameTemp {
                                    resNamesTemp.append(name)
                                }
                            }
                            
                            if let employment = user["employment"] as? NSDictionary, let branch = employment["branch"] as? NSDictionary, let branchName = branch["name"] as? String {
                                resCaptionTemp = branchName
                            }
                            
                            if let address = user["address"] as? NSDictionary, let district = address["district"] as? NSDictionary, let districtName = district["name"] as? String {
                                resCaptionTemp = districtName
                            }
                            
                            //data ni ada kat myagro-dev je
                            if let agency = engage["agency"] as? [String: Any], let name = agency["name"] as? String {
                                resCaptionTemp = name
                            }
                        }
                        
                        respondTemp.append(Respond.init(resNameTemp, responderMessage: resMessageTemp!, responderCaption: resCaptionTemp!, responderPostedDate: resPostedDateTemp!, conversationPostedDate: conPostedDateTemp!))
                    }
                }
                
                completion(respondTemp, resNamesTemp, nil)
            } else {
                //status == 0
                completion(nil, nil, "Failed to retrieved data..")
            }
        }
        
    }
}
