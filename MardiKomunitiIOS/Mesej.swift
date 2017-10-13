//
//  Mesej.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 10/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class Mesej {
    
    var id: Int?
    var projectCategoryId: Int?
    var title: String?
    var content: String?
    var projectName: String?
    var createdDate: String?
    var engagesName: String?
    
    init (_ id: Int, projectCategoryId: Int, title: String, content: String, projectName: String, createdDate: String, engagesName: String) {
        
        self.id = id
        self.projectCategoryId = projectCategoryId
        self.title = title
        self.content = content
        self.projectName = projectName
        self.createdDate = createdDate
        self.engagesName = engagesName
    }
    
    init() {
        
    }
    
    func fetchData(_ completion: @escaping ([Mesej]?, String?) -> ()) {
        
        let networkProcessor = NetworkProcessor.init(URLs.listConversationURL)
        let token = UserDefaults.standard.object(forKey: "MYA_USERTOKEN")
        let params = ["token" : token]
        
        networkProcessor.postRequestJSONFromUrl(params) { (result, responses) in
            
            guard responses == nil else { completion(nil, responses); return; }
            guard let status = result?["status"] as? Int else { return; }
            
            if status == 1 {
                
                var conversationTemp = [Mesej]()
                
                var idTemp = 00000
                var conProjectIDTemp = 999999
                var conTitleTemp = "Tiada tajuk"
                var conContentTemp = "Tiada pengisian"
                var projectNameTemp = "Nama projek tidak di jumpai"
                var conCreatedDateTemp = "99/99/9999"
                var enNameTemp = "Tiada nama di nyatakan"
                
                guard let resultData = result?["data"] as? NSDictionary else { return; }
                guard let conversations = resultData["data"] as? NSArray, conversations.count > 0 else {
                    completion(nil, "Tiada data.");
                    return;
                }
                
                for conversation in conversations {
                    
                    if let id = (conversation as AnyObject).value(forKey: "id") as? Int {
                        idTemp = id
                    }
                    
                    if let conTitle = (conversation as AnyObject).value(forKey: "title") as? String {
                        conTitleTemp = conTitle
                    }
                    
                    if let conContent = (conversation as AnyObject).value(forKey: "content") as? String {
                        conContentTemp = conContent
                    }
                    
                    if let conProjectID = (conversation as AnyObject).value(forKey: "project_id") as? Int {
                        conProjectIDTemp = conProjectID
                    }
                    
                    if let conCreatedDate = (conversation as AnyObject).value(forKey: "created_at") as? String {
                        conCreatedDateTemp = conCreatedDate
                    }
                    
                    if let project = (conversation as AnyObject).value(forKey: "project") as? NSDictionary, let name = project["name"] as? String {
                        projectNameTemp = name
                    }
                    
                    guard let conEngages = (conversation as AnyObject).value(forKey: "engages") as? NSArray, conEngages.count > 0 else { return; }
                    
                    for conEngage in conEngages {
                        
                        guard let user = (conEngage as AnyObject).value(forKey: "user") as? NSDictionary else { return; }
                        
                        if let enName = user["name"] as? String {
                            enNameTemp = enName
                        }
                    }
                    
                    conversationTemp.append(Mesej.init(idTemp, projectCategoryId: conProjectIDTemp, title: conTitleTemp, content: conContentTemp, projectName: projectNameTemp, createdDate: conCreatedDateTemp, engagesName: enNameTemp))
                }
                completion(conversationTemp, nil)
            } else {
                //status == 0
                completion(nil, "Gagal untuk mendapatkan data.");
            }
        }
    }
}















