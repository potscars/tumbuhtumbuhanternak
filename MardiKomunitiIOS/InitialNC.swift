//
//  InitialNC.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 12/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class InitialNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        switch (UserDefaults.standard.object(forKey: "MYA_USERLOGGEDIN") as? Bool) {
            
        case nil:
            print("not logged in")
            
            notLoggedInVC()
            
            break
        case false?:
            
            print("not logged in")
            
            notLoggedInVC()
            
            break
            
        case true?:
            
            print("Trying to go to after login")
            
            loggedInVC()
            
            break
            
        default:
            
            print("technical error")
            
            notLoggedInVC()
            
            break
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func notLoggedInVC()
    {
        let getStoryBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController: BeforeNavController = getStoryBoard.instantiateViewController(withIdentifier: "NotLoggedInNC") as! BeforeNavController
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = viewController
    }
    
    func loggedInVC()
    {
        let getStoryBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController: AfterNavController = getStoryBoard.instantiateViewController(withIdentifier: "AfterNC") as! AfterNavController
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = viewController
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
