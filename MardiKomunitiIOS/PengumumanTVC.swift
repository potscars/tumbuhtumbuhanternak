//
//  PengumumanTVC.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit
import DTZFloatingActionButton

class PengumumanTVC: UITableViewController {
    
    var getJSONData: NSMutableArray = []
    var selectedRow: Int = 0
    
    var dtzButtonAddComment: DTZFloatingActionButton? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ZUISetup.setupTableViewWithTabView(tableView: self)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160.0
        
        grabAnnouncementInfo()
        
        dtzButtonAddComment = DTZFloatingActionButton.init(frame: CGRect.init(x: self.view.frame.size.width - 56 - 14, y: self.view.frame.height - 100 - 14, width: 56, height: 56))
        dtzButtonAddComment!.tag = 100
        dtzButtonAddComment!.buttonColor = Colors.mainGreen
        dtzButtonAddComment!.handler = {
            button in
            self.performSegue(withIdentifier: "MYA_GOTO_WRITE_ARTICLE", sender: self)
        }
        
        self.navigationController?.view.addSubview(dtzButtonAddComment!)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.view.addSubview(dtzButtonAddComment!)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dtzButtonAddComment!.removeFromSuperview()
    }
    
    func grabAnnouncementInfo() {
        
        var np: NetworkProcessor? = nil
        
        if(UserDefaults.standard.object(forKey: "MYA_USERLOGGEDIN") != nil)
        {
            if(UserDefaults.standard.object(forKey: "MYA_USERLOGGEDIN") as! Bool == true) {
                
                print("logged in")
                
                np = NetworkProcessor.init(URLs.loggedAnnouncementURL)
                np!.postRequestJSONFromUrl(["token":UserDefaults.standard.object(forKey: "MYA_USERTOKEN") as! String]) { (result, response) in
                    
                    if result != nil {
                        
                        let convertData: NSDictionary = result! as NSDictionary
                        let grabDataDict: NSDictionary = convertData.value(forKey: "data") as! NSDictionary
                        let grabFullDataArray: NSArray = grabDataDict.value(forKey: "data") as! NSArray
                        
                        for i in 0...grabFullDataArray.count - 1 {
                            
                            let grabData: NSDictionary = grabFullDataArray.object(at: i) as! NSDictionary
                            let getImageArray: NSArray? = grabData.value(forKey: "imageable") as? NSArray
                            
                            self.getJSONData.add([
                                "ARTICLE_TITLE":String.checkStringValidity(data: grabData.value(forKey: "title"), defaultValue: "Data Kosong"),
                                "ARTICLE_CONTENT":String.checkStringValidity(data: grabData.value(forKey: "content"), defaultValue: "Data Kosong"),
                                "ARTICLE_IMAGE":getImageArray ?? []
                                ])
                            
                        }
                        
                        DispatchQueue.main.async {
                            
                            self.tableView.reloadData()
                            
                        }
                        
                    }
                }
                
            } else {
                
                print("logged in but technical problem")
                
                np = NetworkProcessor.init(URLs.guestAnnouncementURL)
                np!.getRequestJSONFromUrl  { (result, response) in
                    
                    if result is NSDictionary {
                        
                        let convertData: NSDictionary = result as! NSDictionary
                        let grabDataDict: NSDictionary = convertData.value(forKey: "data") as! NSDictionary
                        let grabFullDataArray: NSArray = grabDataDict.value(forKey: "data") as! NSArray
                        
                        for i in 0...grabFullDataArray.count - 1 {
                            
                            let grabData: NSDictionary = grabFullDataArray.object(at: i) as! NSDictionary
                            let getImageArray: NSArray? = grabData.value(forKey: "imageable") as? NSArray
                            
                            self.getJSONData.add([
                                "ARTICLE_TITLE":String.checkStringValidity(data: grabData.value(forKey: "title"), defaultValue: "Data Kosong"),
                                "ARTICLE_CONTENT":String.checkStringValidity(data: grabData.value(forKey: "content"), defaultValue: "Data Kosong"),
                                "ARTICLE_IMAGE":getImageArray ?? []
                                ])
                            
                        }
                        
                        DispatchQueue.main.async {
                            
                            self.tableView.reloadData()
                            
                        }
                        
                        
                    } else if result is NSArray {
                        
                        
                    } else {
                        
                        
                    }
                    
                }
                
            }
        } else {
            
             print("not logged in")
            
            np = NetworkProcessor.init(URLs.guestAnnouncementURL)
            np!.getRequestJSONFromUrl  { (result, response) in
                
                if result is NSDictionary {
                    
                    let convertData: NSDictionary = result as! NSDictionary
                    let grabDataDict: NSDictionary = convertData.value(forKey: "data") as! NSDictionary
                    let grabFullDataArray: NSArray = grabDataDict.value(forKey: "data") as! NSArray
                    
                    print("datarray: \(grabDataDict)")
                    print("dataFullarray: \(grabFullDataArray)")
                    
                    
                    for i in 0...grabFullDataArray.count - 1 {
                        
                        let grabData: NSDictionary = grabFullDataArray.object(at: i) as! NSDictionary
                        let getImageArray: NSArray? = grabData.value(forKey: "imageable") as? NSArray
                        
                        self.getJSONData.add([
                            "ARTICLE_TITLE":String.checkStringValidity(data: grabData.value(forKey: "title"), defaultValue: "Data Kosong"),
                            "ARTICLE_CONTENT":String.checkStringValidity(data: grabData.value(forKey: "content"), defaultValue: "Data Kosong"),
                            "ARTICLE_IMAGE":getImageArray ?? []
                            ])
                        
                    }
                    
                    DispatchQueue.main.async {
                        
                        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
                        self.tableView.reloadData()
                        
                    }
                    
                    
                } else if result is NSArray {
                    
                    
                } else {
                    
                    
                }
                
            }
            
        }
        
        
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
        if(getJSONData.count != 0) { return getJSONData.count }
        else { return 1 }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(getJSONData.count != 0){
        
            let checkImageArray: NSDictionary = self.getJSONData.object(at: indexPath.row) as! NSDictionary
            let checkImage: NSArray = checkImageArray.value(forKey: "ARTICLE_IMAGE") as! NSArray
        
            if(checkImage.count != 0){
                let cell: PengumumanTVCell = tableView.dequeueReusableCell(withIdentifier: "PVCWithPicCellID", for: indexPath) as! PengumumanTVCell

                // Configure the cell...
                cell.updateImageCell(data: getJSONData.object(at: indexPath.row) as! NSDictionary)

                return cell
            }
            else {
                let cell: PengumumanTVCell = tableView.dequeueReusableCell(withIdentifier: "PVCNoPicCellID", for: indexPath) as! PengumumanTVCell

                // Configure the cell...
                cell.updateCell(data: getJSONData.object(at: indexPath.row) as! NSDictionary)
            
                return cell
            }
        }
        else {
            let cell: PengumumanTVCell = tableView.dequeueReusableCell(withIdentifier: "PVCLoadingCellID", for: indexPath) as! PengumumanTVCell
            
            // Configure the cell...
            cell.updateLoadingCell(cellIdentifier: cell)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectedRow = indexPath.row
        
        self.performSegue(withIdentifier: "MYA_GOTO_PENGUMUMAN_DETAILS", sender: self)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "MYA_GOTO_PENGUMUMAN_DETAILS" )
        {
            let destViewController: PengumumanDetailsTVC? = segue.destination as? PengumumanDetailsTVC
        
            destViewController?.detailsData = self.getJSONData.object(at: selectedRow) as! NSDictionary
        }
    }
    

}
