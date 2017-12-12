//
//  PengumumanTVC.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit
import DTZFloatingActionButton
import Floaty

class PengumumanTVC: UITableViewController {
    
    var getJSONData: NSMutableArray = []
    var selectedRow: Int = 0
    var refControl = UIRefreshControl()
    
    var dtzButtonAddComment: DTZFloatingActionButton? = nil
    var floatyBtnAddComment: Floaty? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ZUISetup.setupTableViewWithTabView(tableView: self)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160.0
        
        refControl.addTarget(self, action: #selector(gotRefreshing(sender:)), for: UIControlEvents.valueChanged)
        
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refControl
        }
        else {
            self.tableView.addSubview(refControl)
        }
        
        dtzButtonAddComment = DTZFloatingActionButton.init(frame: CGRect.init(x: self.view.frame.size.width - 56 - 14, y: self.view.frame.height - 100 - 14, width: 56, height: 56))
        dtzButtonAddComment!.tag = 100
        dtzButtonAddComment!.buttonColor = Colors.mainGreen
        dtzButtonAddComment!.handler = {
            button in
            self.performSegue(withIdentifier: "MYA_GOTO_WRITE_ARTICLE", sender: self)
        }
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            floatyBtnAddComment = Floaty.init(frame: CGRect.init(x: self.view.center.x + 300, y: self.view.center.y + 450, width: 56, height: 56)) }
        else {
            floatyBtnAddComment = Floaty.init(frame: CGRect.init(x: self.view.center.x + 100, y: self.view.center.y + 230, width: 56, height: 56))
        }
        
        floatyBtnAddComment?.buttonColor = Colors.mainGreen
        floatyBtnAddComment?.plusColor = UIColor.white
        
        let addGesRecg: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(goToWriteArticle(sender:)))
        
        floatyBtnAddComment?.addGestureRecognizer(addGesRecg)
        
        if(Connectivity.checkConnectionToMardi(viewController: self)){
            
            grabAnnouncementInfo()
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(Connectivity.checkConnectionToMardi(viewController: self)){
            if(UserDefaults.standard.object(forKey: "MYA_USERLOGGEDIN") != nil && UserDefaults.standard.object(forKey: "MYA_USERLOGGEDIN") as! Bool == true) {
                
                if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
                    floatyBtnAddComment!.frame = CGRect.init(x: self.view.center.x + 300, y: self.view.center.y + 450, width: 56, height: 56) }
                else {
                    floatyBtnAddComment!.frame = CGRect.init(x: self.view.center.x + 100, y: self.view.center.y + 230, width: 56, height: 56)
                    
                }
                
                floatyBtnAddComment!.layer.removeAllAnimations()
                self.navigationController?.view.addSubview(floatyBtnAddComment!)
            
            }
        }
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if(UserDefaults.standard.object(forKey: "MYA_USERLOGGEDIN") != nil && UserDefaults.standard.object(forKey: "MYA_USERLOGGEDIN") as! Bool == true) {
            floatyBtnAddComment!.removeFromSuperview()
        }
    }
    
    func goToWriteArticle(sender: UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "MYA_GOTO_WRITE_ARTICLE", sender: self)
        
    }
    
    func gotRefreshing(sender: UIRefreshControl) {
        
        grabAnnouncementInfo()
        
    }
    
    func grabAnnouncementInfo() {
        
        self.getJSONData.removeAllObjects()

        if(UserDefaults.standard.object(forKey: "MYA_USERLOGGEDIN") != nil && UserDefaults.standard.object(forKey: "MYA_USERLOGGEDIN") as? Bool == true) {
                
            self.getJSONData = PengumumanData.loggedInData(tableView: self.tableView, refreshControl: refControl) as! NSMutableArray
            
        } else {
         
            self.getJSONData = PengumumanData.nonLoggedInData(tableView: self.tableView, refreshControl: refControl) as! NSMutableArray
            
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
                let cell: PengumumanTVCell = tableView.dequeueReusableCell(withIdentifier: "PVCWithPicIICellID", for: indexPath) as! PengumumanTVCell

                // Configure the cell...
                cell.updateImageCell(data: getJSONData.object(at: indexPath.row) as! NSDictionary, tableView: self.tableView, indexPath: indexPath)
                cell.tag = indexPath.row
                
                return cell
            }
            else {
                let cell: PengumumanTVCell = tableView.dequeueReusableCell(withIdentifier: "PVCNoPicCellID", for: indexPath) as! PengumumanTVCell

                // Configure the cell...
                cell.updateCell(data: getJSONData.object(at: indexPath.row) as! NSDictionary)
                cell.tag = indexPath.row
            
                return cell
            }
        }
        else {
            let cell: PengumumanTVCell = tableView.dequeueReusableCell(withIdentifier: "PVCLoadingCellID", for: indexPath) as! PengumumanTVCell
            
            // Configure the cell...
            cell.updateLoadingCell(cellIdentifier: cell)
            cell.tag = indexPath.row
            
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
