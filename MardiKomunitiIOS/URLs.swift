//
//  URLs.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 05/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class URLs: NSObject {
    
    static let guestAnnouncementURL: String = String.init(format: "%@/api/announcement/list/guest", AppDelegate.switchingURL())
    static let loggedAnnouncementURL: String = String.init(format: "%@/api/announcement/list", AppDelegate.switchingURL())
    static let loginURL: String = String.init(format: "%@/api/login", AppDelegate.switchingURL())
    static let projectByCategoryURL = String.init(format: "%@/api/project/viewbysector", AppDelegate.switchingURL())
    
    static let loadImage: String = String.init(format: "%@/images/original/", AppDelegate.switchingURL())

}
