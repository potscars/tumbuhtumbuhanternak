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
    
    static let guestAnnouncementURL: String = String.init(format: "%@/api/guest", URLs.developmentURL)
    static let loginURL: String = String.init(format: "%@/api/login", URLs.developmentURL)
    static let projectByCategoryURL = "\(URLs.developmentURL)/api/project/viewbysector"
    static let listConversationURL = "\(URLs.developmentURL)/api/conversation"

}
