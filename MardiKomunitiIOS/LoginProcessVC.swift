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
