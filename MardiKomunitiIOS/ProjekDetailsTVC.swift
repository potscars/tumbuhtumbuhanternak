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
    @IBOutlet weak var projekCategoryLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var agencyLabel: UILabel!
    
    var sectionHeader = ["Maklumat Aktiviti", "Lokasi"]
    var expandedHeaderName = [("Sektor", false), ("Sub - Sektor", false), ("Kumpulan Komoditi", false), ("Komuditi", false)]
    var projek: Projek!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profileImage.circledView(profileImage.frame.width)
        
        projekNameLabel.text = projek.name
        projekCategoryLabel.text = projek.projekCategory
        startDateLabel.text = projek.dateStart != "" ? projek.dateStart : "-"
        endDateLabel.text = projek.dateEnd != "" ? projek.dateEnd : "-"
        
        var agencyString = ""
        
        for agency in projek.agency! {
            agencyString += agency
        }
        
        agencyLabel.text = agencyString
    }
    
    func configureTableView() {
        
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200.0
        
        let nibName = UINib(nibName: "ProjectMembersCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: ProjekIdentifier.ProjekMembersCell)
        
        let expandNibName = UINib(nibName: "ExpandableInfoCell", bundle: nil)
        tableView.register(expandNibName, forCellReuseIdentifier: ProjekIdentifier.ExpandableInfoCell)
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return expandedHeaderName.count
        } else {
            return 1
        }
    }
    
    /*
     Section:
     0 - Status - deleted
     1 - Maklumat Aktiviti
     2 - Lokasi
     */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProjekIdentifier.ExpandableInfoCell, for: indexPath) as! ExpandableInfoCell
            
            cell.selectionStyle = .none
            cell.updateView(expandedHeaderName[indexPath.row].0)
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ProjekIdentifier.ProjekLocationCell, for: indexPath)
            
            let featuredImage = cell.viewWithTag(1) as! UIImageView
            let locationLabel = cell.viewWithTag(2) as! UILabel
            
            cell.selectionStyle = .none
            featuredImage.image = #imageLiteral(resourceName: "ic_location_on")
            featuredImage.tintColor = .gray
            locationLabel.text = "Seoul"
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            expandedHeaderName[indexPath.row].1 = !expandedHeaderName[indexPath.row].1
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if expandedHeaderName[indexPath.row].1 {
                return UITableViewAutomaticDimension
            } else {
                return 42.0
            }
        } else {
            return UITableViewAutomaticDimension
        }
    }
}





























