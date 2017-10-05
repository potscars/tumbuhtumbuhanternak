//
//  Connectivity.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 05/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit
import PlainPing

class Connectivity: NSObject {
    
    static func checkConnectionToMardi(viewController: AnyObject) -> Bool {
        
        if(ZNetwork.isConnectedToNetwork() == false)
        {
            print("[Connectivity] No internet connection.")
            
            let alert = UIAlertController(title: "Masalah", message: "Sambungan Internet gagal. Sila periksa sambungan Internet anda.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction) -> Void in
                
            }))
            
            viewController.parent!!.present(alert, animated: true, completion: nil)
            
            return false
        }
        else
        {
            print("[Connectivity] Has internet connection.")
            
            PlainPing.ping("http://myagro.myapp.my", withTimeout: 1.0, completionBlock: {(timeElapsed:Double?, error:Error?) in
                
                if let latency = timeElapsed {
                    
                    print("[Connectivity] Ping detected in elapsed time \(latency)...")
                    
                }
                else if let error = error {
                    
                    print("[Connectivity] Ping error: \(error.localizedDescription)")
                    
                }
                
            })
            
            return true
        }
        
    }

}
