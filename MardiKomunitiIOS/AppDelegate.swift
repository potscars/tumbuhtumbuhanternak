//
//  AppDelegate.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 29/09/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseMessaging

extension UIImage{
    
    func resizeImageWith(newSize: CGSize, opaque: Bool) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, opaque, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func addImagePadding(x: CGFloat, y: CGFloat) -> UIImage? {
        let width: CGFloat = self.size.width + x
        let height: CGFloat = self.size.width + y
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        let origin: CGPoint = CGPoint(x: (width - self.size.width) / 2, y: (height - self.size.height) / 2)
        self.draw(at: origin)
        let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithPadding
    }
    
    func drawInRectAspectFill(rect: CGRect) {
        let targetSize = rect.size
        if targetSize == CGSize.zero {
            return self.draw(in: rect)
        }
        let widthRatio    = targetSize.width  / self.size.width
        let heightRatio   = targetSize.height / self.size.height
        let scalingFactor = max(widthRatio, heightRatio)
        let newSize = CGSize(width:  self.size.width  * scalingFactor,
                             height: self.size.height * scalingFactor)
        UIGraphicsBeginImageContext(targetSize)
        let origin = CGPoint(x: (targetSize.width  - newSize.width)  / 2,
                             y: (targetSize.height - newSize.height) / 2)
        self.draw(in: CGRect(origin: origin, size: newSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        scaledImage!.draw(in: rect)
    }
    
}

extension String {
    
    var length: Int {
        //Deprecated: return self.characters.count
        return self.count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    static func checkStringValidity(data: Any?, defaultValue: String) -> String {
        
        if data is String {
            
            return data as! String
            
        }
        else {
            
            return defaultValue
            
        }
        
    }
    
}

extension DateComponents {
    
    static let DateInLong: String = "dd MMMM yyyy, h:mm:ss a"
    static let DateInShort: String = "dd/MM/yy"
    
    static func dateFormatConverter(valueInString: String, dateTimeFormatFrom: String?, dateTimeFormatTo: String?) -> String {
        
        let originalDate: DateFormatter = DateFormatter()
        originalDate.timeZone = NSTimeZone(name: "GMT+08:00")! as TimeZone
        if(dateTimeFormatFrom != nil) { originalDate.dateFormat = dateTimeFormatFrom } else { originalDate.dateFormat = "yyyy-MM-dd HH:mm:ss" }
        let setDate: Date = originalDate.date(from: valueInString)!
        if(dateTimeFormatTo != nil) { originalDate.dateFormat = dateTimeFormatTo } else { originalDate.dateFormat = DateInLong }
        
        
        return String(utf8String: originalDate.string(from: setDate))!
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static let developmentModeManual: Bool? = false // false for production, true for debug, nil for auto
    
    static var temporaryData: AnyObject? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        self.registerForPushNotifications(application: application)
        Messaging.messaging().delegate = self
        
        if let token = InstanceID.instanceID().token() {
            NSLog("FCM TOKEN : \(token)")
            UserDefaults.standard.set(token, forKey: "FCM_TOKEN")
            self.connectToFcm()
        }
        
        application.registerForRemoteNotifications()
        
        self.navigationBar()
        
        return true
    }
    
    static func switchingURL() -> String {
        
        let devUrl: String = "http://myagro-dev.myapp.my"
        let relUrl: String = "http://myagro.myapp.my"
        
        if(developmentModeManual != nil && developmentModeManual == true) {
            return devUrl //development URL
        }
        else if(developmentModeManual != nil && developmentModeManual == false) {
            return relUrl //production URL
        }
        else {
            #if DEBUG
                return devUrl //development URL
            #else
                return relUrl //production URL
            #endif
        }
        
    }
    
    func navigationBar() {
        
        UINavigationBar.appearance().barTintColor = Colors.mainGreen
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
        UITabBar.appearance().barTintColor = Colors.mainGreen
        UITabBar.appearance().tintColor = UIColor.white
        
        let attributes: [String : Any] = [ NSFontAttributeName: UIFont(name: "Futura-Bold", size: 12.0)!]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UITabBarItem.appearance().titlePositionAdjustment.vertical = -15
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Messaging.messaging().shouldEstablishDirectChannel = false
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        Messaging.messaging().shouldEstablishDirectChannel = true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //Register for push notification.
    func registerForPushNotifications(application: UIApplication) {
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.alert,.sound]) { (granted, error) in
                if error == nil{
                    DispatchQueue.main.async(execute: {
                        application.registerForRemoteNotifications()
                    })
                }
            }
        }
        else {
            
            let settings = UIUserNotificationSettings(types: [.alert,.sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
        
        // Add observer for InstanceID token refresh callback.
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        
    }
    
    @objc func tokenRefreshNotification(_ notification: Notification) {
        print(#function)
        if let refreshedToken = InstanceID.instanceID().token() {
            NSLog("Notification: refresh token from FCM -> \(refreshedToken)")
            
        }
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
    
    func connectToFcm() {
        // Won't connect since there is no token
        guard InstanceID.instanceID().token() != nil else {
            NSLog("FCM: Token does not exist.")
            return
        }
        
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // iOS10+, called when presenting notification in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        NSLog("[UserNotificationCenter] willPresentNotification: \(userInfo)")
        //TODO: Handle foreground notification
        completionHandler([.alert])
    }
    
    // iOS10+, called when received response (default open, dismiss or custom action) for a notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        NSLog("[UserNotificationCenter] didReceiveResponse: \(userInfo)")
        //TODO: Handle background notification
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    
    //MARK: FCM Token Refreshed
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        NSLog("[RemoteNotification] didRefreshRegistrationToken: \(fcmToken)")
    }
     
    // Receive data message on iOS 10 devices while app is in the foreground.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        NSLog("remoteMessage: \(remoteMessage.appData)")
    }
}











