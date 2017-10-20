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
    
    var sectionHeader = ["Status", "Maklumat Aktiviti", "Lokasi"]
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
        startDateLabel.text = projek.dateStart
        endDateLabel.text = projek.dateEnd
        
        var agencyString = ""
        
        for agency in projek.agency! {
            agencyString += agency
            return
        }
        
        agencyLabel.text = agencyString
        
    }
    
    func configureTableView() {
        
        tableView.separatorStyle = .none
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 20.0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProjekIdentifier.ProjekStatusCell, for: indexPath)
            
            let featuredImage = cell.viewWithTag(1) as! UIImageView
            
            featuredImage.image = #imageLiteral(resourceName: "ic_check_circle")
            featuredImage.tintColor = .green
            
            return cell
        } else if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProjekIdentifier.ProjekDescriptionCell, for: indexPath)

            let descriptionLabel = cell.viewWithTag(1) as! UILabel
            descriptionLabel.text = "Tiada maklumat mengenai projek ini buat masa kini."
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ProjekIdentifier.ProjekLocationCell, for: indexPath)
            
            let featuredImage = cell.viewWithTag(1) as! UIImageView
            let locationLabel = cell.viewWithTag(2) as! UILabel
            
            featuredImage.image = #imageLiteral(resourceName: "ic_location_on")
            featuredImage.tintColor = .gray
            locationLabel.text = "Seoul"
            
            return cell
        }
    }
}





























