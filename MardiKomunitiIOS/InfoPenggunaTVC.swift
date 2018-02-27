//
//  InfoPenggunaTVC.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class InfoPenggunaTVC: UITableViewController {
    
    var menuInfo: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ZUISetup.setupTableViewWithTabView(tableView: self)
        ZGraphics.hideTableSeparatorAfterLastCell(tableView: self.tableView)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80.0
        
        menuInfo.add(["PROFILE_USERNAME":UserDefaults.standard.object(forKey: "MYA_NAME") as! String])
        menuInfo.add(["MENU_NAME":"Tetapan", "MENU_ICON":"ic_cog.png"])
        menuInfo.add(["MENU_NAME":"Berkenaan Aplikasi", "MENU_ICON":"ic_info.png"])
        menuInfo.add(["MENU_NAME":"Log Keluar", "MENU_ICON":"ic_logout.png"])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let imagePath = UserDefaults.standard.object(forKey: "MYA_USERIMAGE")
        print(imagePath as! String)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuInfo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0) {
            
            let cell: InfoPenggunaTVCell = tableView.dequeueReusableCell(withIdentifier: "IPUserInfoCellID", for: indexPath) as! InfoPenggunaTVCell
            
            // Configure the cell...
            cell.updateUserProfile(data: menuInfo.object(at: indexPath.row) as! NSDictionary)
            
            return cell
            
        }
        else {
            
            let cell: InfoPenggunaTVCell = tableView.dequeueReusableCell(withIdentifier: "IPMenuCellID", for: indexPath) as! InfoPenggunaTVCell
            
            // Configure the cell...
            cell.updateSettings(data: menuInfo.object(at: indexPath.row) as! NSDictionary)
            
            return cell
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.row) {
        case 0:
            self.performSegue(withIdentifier: "MYA_GOTO_USERINFO", sender: self)
            break
        case 1:
            self.performSegue(withIdentifier: "MYA_GOTO_SETTINGS", sender: self)
            break
        case 2:
            self.performSegue(withIdentifier: "MYA_GOTO_ABOUT", sender: self)
            break
        case 3:
            logOut()
            break
        default:
            break
        }
    }
    
    func logOut() {
        
        let alertView: UIAlertController = UIAlertController.init(title: "Log Keluar", message: "Anda pasti untuk mendaftar keluar dari aplikasi?", preferredStyle: UIAlertControllerStyle.alert)
        
        let alertCancelAction: UIAlertAction = UIAlertAction.init(title: "Tidak", style: UIAlertActionStyle.default, handler: { (action) in
            
            alertView.dismiss(animated: true, completion: { (Void) in })
            
        })
        
        alertView.addAction(alertCancelAction)
        
        let alertOKAction: UIAlertAction = UIAlertAction.init(title: "Ya", style: UIAlertActionStyle.default, handler: { (action) in
            
            UserDefaults.standard.set(false, forKey: "MYA_USERLOGGEDIN")
            UserDefaults.standard.set("", forKey: "MYA_USERID")
            UserDefaults.standard.set("", forKey: "MYA_USERNAME")
            UserDefaults.standard.set("", forKey: "MYA_ALTUSERNAME")
            UserDefaults.standard.set("", forKey: "MYA_NAME")
            UserDefaults.standard.set("", forKey: "MYA_ICNO")
            UserDefaults.standard.set("", forKey: "MYA_EMAIL")
            UserDefaults.standard.set("", forKey: "MYA_ROLES_ARR")
            UserDefaults.standard.set("", forKey: "MYA_ADDRESS_ARR")
            UserDefaults.standard.set("", forKey: "MYA_USERTOKEN")
            
            let getStoryBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController: BeforeNavController = getStoryBoard.instantiateViewController(withIdentifier: "NotLoggedInNC") as! BeforeNavController
            let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDel.window?.rootViewController = viewController
            
            alertView.dismiss(animated: true, completion: { (Void) in })
            
        })
        
        alertView.addAction(alertOKAction)
        
        alertView.preferredAction = alertCancelAction
        
        self.present(alertView, animated: true, completion: nil)
        
    }
}










