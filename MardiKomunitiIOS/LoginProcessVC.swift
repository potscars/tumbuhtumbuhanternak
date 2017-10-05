//
//  LoginProcessVC.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 04/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoginProcessVC: UIViewController {
    
    @IBOutlet weak var uivLPVCLoadingContainer: UIView!
    @IBOutlet weak var nvaivLPVCIndicator: UIView!
    
    var loginData: NSDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let xAxis = self.view.center.x
        let yAxis = self.view.center.y
        let setLoadingFrame = CGRect.init(x: xAxis - 20, y: yAxis - 30, width: 50, height: 50)
        let setTextFrame = CGRect.init(x: xAxis - 60, y: yAxis + 10, width: 150, height: 50)
        let nvIndicator: NVActivityIndicatorView = NVActivityIndicatorView.init(frame: setLoadingFrame, type: .ballPulse, color: UIColor.init(red: 6.0/255.0, green: 142.0/255.0, blue: 61.0/255.0, alpha: 1), padding: nil)
        let textView: UITextView = UITextView.init(frame: setTextFrame)
        textView.text = "Sedang memuatkan..."
        
        self.view.addSubview(nvIndicator)
        self.view.addSubview(textView)
        nvIndicator.startAnimating()
        
        //nvaivLPVCIndicator.type = .ballPulse
        //nvaivLPVCIndicator.frame = setFrame
        //nvaivLPVCIndicator.bounds = setFrame
        //nvaivLPVCIndicator.startAnimating()
        
        loginProcess()
    }
    
    func loginProcess() {
        
        let np: NetworkProcessor = NetworkProcessor.init(URLs.loginURL)
        
        let loginParamParam: [String : Any] = ["username":loginData.value(forKey: "username") as! String,
                                               "password":loginData.value(forKey: "password") as! String]
        
        np.uploadJSONData(loginParamParam) { (result, response) in
            
            if(result != nil) {
                
                if(result!["status"] as! Int == 1) {
                    
                    print("Login success...")
                    
                    let data: NSDictionary = result!["data"] as! NSDictionary
                    
                    print("dataaq: \(data)")
                    
                    UserDefaults.standard.set(true, forKey: "MYA_USERLOGGEDIN")
                    UserDefaults.standard.set(data.value(forKey: "user_id") ?? "", forKey: "MYA_USERID")
                    UserDefaults.standard.set(data.value(forKey: "username") ?? "", forKey: "MYA_USERNAME")
                    UserDefaults.standard.set(data.value(forKey: "alt_username") ?? "", forKey: "MYA_ALTUSERNAME")
                    UserDefaults.standard.set(data.value(forKey: "name") ?? "", forKey: "MYA_NAME")
                    UserDefaults.standard.set(data.value(forKey: "ic_no") ?? "", forKey: "MYA_ICNO")
                    UserDefaults.standard.set(data.value(forKey: "hp_no") ?? "", forKey: "MYA_HPNO")
                    UserDefaults.standard.set(data.value(forKey: "email") ?? "", forKey: "MYA_EMAIL")
                    UserDefaults.standard.set(data.value(forKey: "roles") ?? "", forKey: "MYA_ROLES_ARR")
                    UserDefaults.standard.set(data.value(forKey: "address") ?? "", forKey: "MYA_ADDRESS_ARR")
                    UserDefaults.standard.set(data.value(forKey: "token") ?? "", forKey: "MYA_USERTOKEN")
                    
                    //in future, remember me will be set
                    //in future, language will be set
                    self.performSegue(withIdentifier: "MYA_LOGGED_GOTO_MAIN", sender: self)
                    
                }
                else {
                    
                    UserDefaults.standard.set(false, forKey: "MYA_USERLOGGEDIN")
                    UserDefaults.standard.set(result!["status"], forKey: "MYA_LOGINFAILSTATUS")
                    UserDefaults.standard.set(result!["message"], forKey: "MYA_LOGINFAILMESSAGE")
                    
                    ZUIs.showOKDialogBox(viewController: self, dialogTitle: "Masalah", dialogMessage: "Sila periksa nama pengguna dan kata laluan anda.", afterDialogDismissed: "BACK_TO_PREVIOUS_VIEWCONTROLLER")
                }
            } else {
                ZUIs.showOKDialogBox(viewController: self, dialogTitle: "Masalah", dialogMessage: "Sila cuba sebentar lagi.", afterDialogDismissed: "BACK_TO_PREVIOUS_VIEWCONTROLLER")
            }
        
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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