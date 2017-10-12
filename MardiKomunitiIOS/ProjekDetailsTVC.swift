//
//  ProjekDetailsTVC.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 11/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class ProjekDetailsTVC: UITableViewController {
    
    //iboutlet
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var projekNameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDataLabel: UILabel!
    
    var sectionHeader = ["Location", "Members"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profileImage.circledView(profileImage.frame.width)
    }
    
    func configureTableView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200.0
        
        let nibName = UINib(nibName: "ProjectMembersCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: ProjekIdentifier.ProjekMembersCell)
    }
}

extension ProjekDetailsTVC {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionHeader.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return 5
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProjekIdentifier.ProjekLocationCell, for: indexPath)
            
            let featuredImage = cell.viewWithTag(1) as! UIImageView
            let townNameLabel = cell.viewWithTag(2) as! UILabel
            let streetNameLabel = cell.viewWithTag(3) as! UILabel
            
            featuredImage.image = #imageLiteral(resourceName: "ic_location_on")
            
            townNameLabel.text = "Seoul"
            streetNameLabel.text = "Lot 2 Sky Path"
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ProjekIdentifier.ProjekMembersCell, for: indexPath) as! ProjectMembersCell
            
            return cell
        }
    }
}





























