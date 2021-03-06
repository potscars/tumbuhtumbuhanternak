//
//  PengumumanDetailsTVC.swift
//  MardiKomunitiIOS
//
//  Created by Mohd Zulhilmi Mohd Zain on 03/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class PengumumanDetailsTVC: UITableViewController {
    
    var detailsData: NSDictionary = [:]
    var updatingImage: Bool = false
    var getImageArray: NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ZUISetup.setupTableViewWithTabView(tableView: self)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120.0
        
        ZGraphics.hideTableSeparatorAfterLastCell(tableView: self.tableView)
        
        self.getImageArray = detailsData.value(forKey: "ARTICLE_IMAGE") as? NSArray ?? []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if(self.getImageArray.count != 0) { return 3 }
        else { return 2 }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(self.getImageArray.count != 0) {
            if(section == 0) { return 1 }
            else if (section == 1) { return self.getImageArray.count }
            else { return 1 }
        } else {
            if(section == 0) { return 1 }
            else { return 1 }
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0) {
            let cell: PengumumanDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "PDSenderInfoCellID", for: indexPath) as! PengumumanDetailsTVCell

            // Configure the cell...
            self.updatingImage = false
            cell.updateSenderInfo(data: detailsData.value(forKey: "ARTICLE_SENDER") as? NSDictionary ?? [:])
            cell.tag = indexPath.row

            return cell
        }
        else if(indexPath.section == 1 && self.getImageArray.count != 0) {
            let cell: PengumumanDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "PDImageCellID", for: indexPath) as! PengumumanDetailsTVCell
            
            let imageArray: NSArray = detailsData.value(forKey: "ARTICLE_IMAGE") as! NSArray
        
            // Configure the cell...
            cell.updateSenderImage(data: imageArray, tableView: self.tableView, indexPath: indexPath)
            self.updatingImage = true
            cell.tag = indexPath.row
            
            return cell
        }
        else {
            let cell: PengumumanDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "PDFullDescCellID", for: indexPath) as! PengumumanDetailsTVCell
            
            // Configure the cell...
            cell.updateDescriptions(data: detailsData)
            self.updatingImage = false
            cell.tag = indexPath.row
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 && UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad && self.getImageArray.count != 0 { return 500.0 }
        else if indexPath.section == 1 && UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && self.getImageArray.count != 0 { return 250.0 }
        else { return UITableViewAutomaticDimension }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
