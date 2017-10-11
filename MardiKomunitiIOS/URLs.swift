//
//  URLs.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 05/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class URLs: NSObject {
    
    static let developmentURL: String = "http://myagro.myapp.my"
    static let productionURL: String = ""
    
    static let guestAnnouncementURL: String = String.init(format: "%@/api/announcement/list/guest", URLs.developmentURL)
    static let loginURL: String = String.init(format: "%@/api/login", URLs.developmentURL)
    static let projectByCategoryURL = String.init(format: "%@/api/project/viewbysector", URLs.developmentURL)

}
