//
//  LoginVC.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 04/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var uiivLVCAppImage: UIImageView!
    @IBOutlet weak var uitfLVCUsername: UITextField!
    @IBOutlet weak var uitfLVCPassword: UITextField!
    @IBOutlet weak var uibLVCLogin: UIButton!
    
    var textEditing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        ZGraphics.stylizingTextField(target: uitfLVCUsername)
        ZGraphics.stylizingTextField(target: uitfLVCPassword)
        ZGraphics.stylizingButton(target: uibLVCLogin)
        uitfLVCUsername.delegate = self
        uitfLVCPassword.delegate = self
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        print("showing keyboard...")
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        print("hiding keyboard...")
        if(uitfLVCPassword.isFirstResponder == true) {
            if let keyboardSize = (notification.userInfo?   [UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y != 0{
                    self.view.frame.origin.y += keyboardSize.height
                }
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        print("begin editing...")
        self.textEditing = true
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(uitfLVCUsername.isFirstResponder == true) {
            uitfLVCUsername.resignFirstResponder()
            uitfLVCPassword.becomeFirstResponder()
        } else if(uitfLVCPassword.isFirstResponder == true) {
            uitfLVCUsername.resignFirstResponder()
            uitfLVCPassword.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        
        
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
