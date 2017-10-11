//
//  Projek.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 06/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class Projeks {
    
    var title : String!
    var projek : [Projek]!
    
    init(title: String, projek:[Projek]) {
        self.title = title
        self.projek = projek
    }
    
    init() {
    }
    
    func fetchProjek(_ completion: @escaping ([Projeks]) -> ()) {
        
        print("fetchinggg")
        
        let networkProcessors = NetworkProcessor.init(URLs.projectByCategoryURL)
        let token = UserDefaults.standard.object(forKey: "MYA_USERTOKEN")
        
        let params = ["token" : token]
        
        networkProcessors.postRequestJSONFromUrl(params) { (data, responses) in
            
            guard responses == nil else { return }
            guard let status = data?["status"] as? Int else { return; }
            
            if status == 1 {
                
                guard let dataResults = data?["data"] as? NSArray, dataResults.count > 0 else { return; }
                
                var projeksTemp = [Projeks]()
                
                //tempt string to hold project json
                var projectId: Int = 99999
                var projectName: String = ""
                var projectDateStart: String = "1885"
                var projectCategoryName: String = ""
                
                var enrollName: String = "Kim Byung Man"
                var enrollUsername: String = "Chief"
                var enrollICNumber: String = "0000"
                var enrollPhoneNumber: String = "0000"
                
                for dataResult in dataResults {
                    
                    var projekTemp = [Projek]()
                    
                    let projekCategory = (dataResult as AnyObject).value(forKey: "name") as! String
                    
                    guard let projects = (dataResult as AnyObject).value(forKey: "projects") as? NSArray, projects.count > 0 else { return }
                    
                    for project in projects {
                        
                        var projekEnrollsTemp = [Enrolls]()
                        
                        if let id = (project as AnyObject).value(forKey: "id") as? Int {
                            projectId = id
                        }
                        
                        if let name = (project as AnyObject).value(forKey: "name") as? String {
                            projectName = name
                        }
                        
                        if let dateStart = (project as AnyObject).value(forKey: "date_start") as? String {
                            projectDateStart = dateStart
                        }
                        
                        if let category = (project as AnyObject).value(forKey: "project_category") as? NSDictionary, let name = category["name"] as? String {
                            projectCategoryName = name
                        }
                        
                        guard let enrolls = (project as AnyObject).value(forKey: "enrolls") as? NSArray, enrolls.count > 0 else { return }
                        
                        for enroll in enrolls {

                            guard let user = (enroll as AnyObject).value(forKey: "user") as? NSDictionary else { return }
                            
                            if let name = user["name"] as? String{
                                enrollName = name
                            }
                            
                            if let username = user["username"] as? String{
                                enrollUsername = username
                            }
                            
                            if let icNumber = user["ic_no"] as? String{
                                enrollICNumber = icNumber
                            }
                            
                            if let phoneNumber = user["hp_no"] as? String{
                                enrollPhoneNumber = phoneNumber
                            }
                            
                            projekEnrollsTemp.append(Enrolls(name: enrollName, username: enrollUsername, icNumber: enrollICNumber, phoneNumber: enrollPhoneNumber))
                        }
                        
                        projekTemp.append(Projek(projectId, name: projectName, dateStart: projectDateStart, projekCategory: projectCategoryName, enrolls: projekEnrollsTemp))
                    }
                    
                    projeksTemp.append(Projeks(title: projekCategory, projek: projekTemp))
                }
                
                completion(projeksTemp)
            }
        }
    }
}

class Projek {
    
    var id : Int?
    var name : String?
    var dateStart : String?
    var projekCategory : String?
    var enrolls: [Enrolls]?
    
    init(_ id: Int, name: String, dateStart: String, projekCategory: String, enrolls: [Enrolls]) {
        
        self.id = id
        self.name = name
        self.dateStart = dateStart
        self.projekCategory = projekCategory
        self.enrolls = enrolls
    }
}

class Enrolls {
    
    var name : String?
    var username : String?
    var icNumber : String?
    var phoneNumber : String?
    
    init (name: String, username: String, icNumber: String, phoneNumber: String) {
        
        self.name = name
        self.username = username
        self.icNumber = icNumber
        self.phoneNumber = phoneNumber
    }
}

//"enrolls": [
//{
//"id": 36,
//"user_id": 14,
//"project_id": 7,
//"address_id": 86,
//"role_id": 1,
//"status": "1",
//"created_at": "-0001-11-30 00:00:00",
//"updated_at": "-0001-11-30 00:00:00",
//"user": {
//"id": 14,
//"address_id": 5,
//"username": "eruan.hanapi",
//"alt_username": "",
//"name": "Eruan Bin Hanapi",
//"ic_no": "761003025905",
//"hp_no": "019-5619075",
//"phone_no": "",
//"email": null,
//"remember_token": null,
//"created_at": "2017-10-05 16:04:33",
//"updated_at": "2017-10-05 16:04:33"
//}
//},










