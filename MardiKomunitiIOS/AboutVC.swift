//
//  AboutVC.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 25/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    @IBOutlet weak var uilAVCAppTitleLabel: UILabel!
    @IBOutlet weak var uilAVCAppVerLabel: UILabel!
    @IBOutlet weak var uilAVCAppBuildLabel: UILabel!
    @IBOutlet weak var uilAVCAppCopyLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let version: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let buildNo: String? = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        let currentDate = Date.init()
        let calendar = Calendar.current
        let getYear = calendar.component(Calendar.Component.year, from: currentDate)
        
        uilAVCAppTitleLabel.text = "m@MYAgro"
        uilAVCAppVerLabel.text = "Versi \(String(describing: version ?? ""))"
        uilAVCAppBuildLabel.text = "Binaan \(String(describing: buildNo ?? ""))"
        uilAVCAppCopyLabel.text = "Hakcipta © \(getYear) Ingeniworks Sdn. Bhd."
        
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
