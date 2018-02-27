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
    
    func fetchProjek(_ completion: @escaping ([Projeks]?, String?) -> ()) {
        
        print("fetchinggg")
        
        let networkProcessors = NetworkProcessor.init(URLs.projectByCategoryURL)
        let token = UserDefaults.standard.object(forKey: "MYA_USERTOKEN")
        let params = ["token" : token]
        
        networkProcessors.postRequestJSONFromUrl(params) { (data, responses) in
            
            guard responses == nil else {
                return
            }
            guard let status = (data as AnyObject).object(forKey: "status") as? Int else {
                completion(nil, "Maaf, masalah teknikal.")
                return
            }
            
            if status == 1 {
                
                var projeksTemp = [Projeks]()
                
                guard let dataResults = data?["data"] as? NSArray, dataResults.count > 0 else {
                    completion(nil, "Tiada data.")
                    return;
                }
                
                //tempt string to hold project json
                var projectId: Int = 99999
                var projectName: String = ""
                var projectDateEnd: String = ""
                var projectDateStart: String = ""
                var projectAgency = [String]()
                var projectCategoryName: String = ""
                
                var enrollName: String = "Kim Byung Man"
                var enrollUsername: String = "Chief"
                var enrollICNumber: String = "0000"
                var enrollPhoneNumber: String = "0000"
                var agencyNameTemp: String = ""
                
                for dataResult in dataResults {
                    
                    var projekTemp = [Projek]()
                    
                    let projekCategory = (dataResult as AnyObject).value(forKey: "name") as! String
                    guard let projects = (dataResult as AnyObject).value(forKey: "projects") as? NSArray else { return }

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
                        
                        if let dateEnd = (project as AnyObject).value(forKey: "date_end") as? String {
                            projectDateEnd = dateEnd
                        }
                        
                        if let category = (project as AnyObject).value(forKey: "project_category") as? NSDictionary, let name = category["name"] as? String {
                            projectCategoryName = name
                        }
                        
                        if let conducts = (project as AnyObject).value(forKey: "conducts") as? NSArray {
                            for conduct in conducts {
                                
                                if let agency = (conduct as AnyObject).value(forKey: "agency") as? NSDictionary, let agencyName = agency["name"] as? String {
                                    print(agencyName)
                                    projectAgency.append(agencyName)
                                }
                            }
                        }
                        
                        if let enrolls = (project as AnyObject).value(forKey: "enrolls") as? NSArray {

                            for enroll in enrolls {
                                var taxonomyTemp: [String: Any] = [:]
                                
                                if let address = (enroll as AnyObject).value(forKey: "address") as? NSDictionary, let district = address["district"] as? NSDictionary, let districtName = district["name"] as? String {
                                    
                                    agencyNameTemp = districtName
                                }
                                
                                if let enlist = (enroll as AnyObject).value(forKey: "enlist") as? NSDictionary {
                                    
                                    if let user = enlist["user"] as? NSDictionary {
                                        if let name = user["name"] as? String {
                                            enrollName = name
                                        }
                                        
                                        /*
                                         1 - sektor
                                         2 - sub sektor
                                         3 - kump komiditi
                                         4 - komiditi
                                         */
                                        
                                        if let taxos = user["taxonomies"] as? NSArray {
                                            print("TOXOS: \(taxos)")
                                            for taxo in taxos {
                                                
                                                taxonomyTemp = self.getTaxonomyName(taxoData: taxo as AnyObject, taxoTemp: taxonomyTemp)
                                                if let parent1 = (taxo as AnyObject).object(forKey: "parent") as? [String: Any] {
                                                    taxonomyTemp = self.getTaxonomyName(taxoData: parent1 as AnyObject, taxoTemp: taxonomyTemp)
                                                    if let parent2 = parent1["parent"] as? [String: Any]
                                                    {
                                                        taxonomyTemp = self.getTaxonomyName(taxoData: parent2 as AnyObject, taxoTemp: taxonomyTemp)
                                                        if let parent3 = parent2["parent"] as? [String: Any]
                                                        {
                                                            taxonomyTemp = self.getTaxonomyName(taxoData: parent3 as AnyObject, taxoTemp: taxonomyTemp)
                                                        }
                                                    }
                                                }
                                                print("TaxDetails: \(taxonomyTemp)")
                                            }
                                        }
                                    }
                                }
                                
                                projekEnrollsTemp.append(Enrolls(name: enrollName, username: enrollUsername, icNumber: enrollICNumber, phoneNumber: enrollPhoneNumber, agency: agencyNameTemp, taxonomy: taxonomyTemp))
                            }
                        }
                        
                        projekTemp.append(Projek(projectId, name: projectName, dateStart: projectDateStart, dateEnd: projectDateEnd, agency: projectAgency, projekCategory: projectCategoryName, enrolls: projekEnrollsTemp))
                    }
                    
                    projeksTemp.append(Projeks(title: projekCategory, projek: projekTemp))
                }
                
                completion(projeksTemp, nil)
            } else {
                completion(nil, "Maaf, masalah teknikal.")
            }
        }
    }
    
    func getTaxonomyName(taxoData: AnyObject, taxoTemp: [String: Any]) -> [String: Any] {
        
        var newTaxoTemp = taxoTemp
        print("MORE TAXO \(newTaxoTemp)")
        if let taxoId = taxoData.object(forKey: "taxonomy_group_id") as? Int {
            
            if let name = taxoData.object(forKey: "name") as? String {
                print("\(taxoId) \(name)")
                if taxoId == 1 {
                    newTaxoTemp.updateValue(name, forKey: "SEKTOR")
                } else if taxoId == 2 {
                    newTaxoTemp.updateValue(name, forKey: "SUB-SEKTOR")
                } else if taxoId == 3 {
                    newTaxoTemp.updateValue(name, forKey: "KUMP KOMUDITI")
                } else if taxoId == 4 {
                    newTaxoTemp.updateValue(name, forKey: "KOMUDITI")
                } else {
                    newTaxoTemp.updateValue(name, forKey: "VARIASI")
                }
            }
        }
        
        return newTaxoTemp
    }
}

class Projek {
    
    var id : Int?
    var name : String?
    var dateStart : String?
    var dateEnd: String?
    var agency: [String]?
    var projekCategory : String?
    var enrolls: [Enrolls]?
    
    init(_ id: Int, name: String, dateStart: String, dateEnd: String, agency: [String], projekCategory: String, enrolls: [Enrolls]) {
        
        self.id = id
        self.name = name
        self.dateStart = dateStart
        self.dateEnd = dateEnd
        self.agency = agency
        self.projekCategory = projekCategory
        self.enrolls = enrolls
    }
}

class Enrolls {
    
    var name : String?
    var username : String?
    var icNumber : String?
    var phoneNumber : String?
    var agency: String?
    var taxonomy: [String: Any]?
    
    init (name: String, username: String, icNumber: String, phoneNumber: String, agency: String?, taxonomy: [String: Any]) {
        
        self.name = name
        self.username = username
        self.icNumber = icNumber
        self.phoneNumber = phoneNumber
        self.agency = agency
        self.taxonomy = taxonomy
    }
}










