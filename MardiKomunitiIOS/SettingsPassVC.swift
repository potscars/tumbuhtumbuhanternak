//
//  SettingsPassVC.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 20/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class SettingsPassVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var uitfSPVCOldPass: UITextField!
    @IBOutlet weak var uitfSPVCNewPass: UITextField!
    @IBOutlet weak var uitfSPVCConfirmPass: UITextField!
    @IBOutlet weak var uibSPVCOKBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        uitfSPVCOldPass.delegate = self
        uitfSPVCNewPass.delegate = self
        uitfSPVCConfirmPass.delegate = self
        
        uibSPVCOKBtn.addTarget(self, action: #selector(perform(sender:)), for: UIControlEvents.touchUpInside)
        
    }
    
    func perform(sender: UIButton) {
        
        if(uitfSPVCOldPass.text != "") {
            
            if(uitfSPVCNewPass.text != "") {
                
                if(uitfSPVCConfirmPass.text != "") {
                    
                    if(uitfSPVCConfirmPass.text == uitfSPVCNewPass.text) {
                        
                    } else {
                        
                        ZUIs.showOKDialogBox(viewController: self, dialogTitle: "Tidak Sah", dialogMessage: "Katalaluan pengesahan mesti disahkan sama dengan katalaluan baru.", afterDialogDismissed: nil)
                        
                    }
                    
                } else {
                    
                    ZUIs.showOKDialogBox(viewController: self, dialogTitle: "Tidak Sah", dialogMessage: "Sila isi katalaluan pengesahan.", afterDialogDismissed: nil)
                    
                }
                
            } else {
                
                ZUIs.showOKDialogBox(viewController: self, dialogTitle: "Tidak Sah", dialogMessage: "Sila isi katalaluan baru.", afterDialogDismissed: nil)
                
            }
            
        } else {
            
            ZUIs.showOKDialogBox(viewController: self, dialogTitle: "Tidak Sah", dialogMessage: "Sila isi katalaluan lama.", afterDialogDismissed: nil)
            
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        ZGraphics.moveViewYPosition(view: self.view, yPosition: 100, animationDuration: 0.2, moveToUp: true)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        ZGraphics.moveViewYPosition(view: self.view, yPosition: 100, animationDuration: 0.2, moveToUp: false)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(uitfSPVCOldPass.isFirstResponder) { uitfSPVCOldPass.resignFirstResponder() }
        else if(uitfSPVCNewPass.isFirstResponder) { uitfSPVCNewPass.resignFirstResponder() }
        else if(uitfSPVCConfirmPass.isFirstResponder) { uitfSPVCConfirmPass.resignFirstResponder() }
     
        return true
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
