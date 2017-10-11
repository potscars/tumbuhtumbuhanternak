//
//  ProjectTVC.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 06/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

struct ProjekIdentifier {
    
    static let ProjekCell = "projekCell"
    static let ProjekDetailSegue = "projekDetailsSegue"
}

class ProjectTVC: UITableViewController {
    
    var sectionHeader = ["PERIKANAN", "TANAMAN", "TERNAKAN"]
    var projeksData = [Projeks]()
    var spinner: LoadingSpinner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner = LoadingSpinner(view: self.view, isNavBar: true)
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let projek = Projeks()
        
        if projeksData.count <= 0 {
            
            spinner.setLoadingScreen()
            projek.fetchProjek { (data) in
                
                DispatchQueue.main.async {
                    
                    self.projeksData = data
                    self.spinner.removeLoadingScreen()
                    self.tableView.separatorStyle = .singleLine
                    self.tableView.reloadData()
                }
            }
        } else {
            spinner.removeLoadingScreen()
        }
    }
    
    func configureTableView() {
        
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsetsMake(0, 0, (tabBarController?.tabBar.frame.height)!, 0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return projeksData.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
        headerView.backgroundColor = Colors.mainGreen.withAlphaComponent(0.9)
        
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Futura-Bold", size: 16.0)!
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = projeksData[section].title
        headerView.addSubview(label)
        label.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16).isActive = true
        label.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: 16).isActive = true
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(projeksData[section].projek.count)
        return projeksData[section].projek.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjekIdentifier.ProjekCell, for: indexPath) as! ProjekCell
        
        cell.selectionStyle = .none
        print(projeksData[section].projek.count)
        cell.updateUI(indexPath.row, projek: projeksData[section].projek[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ProjekIdentifier.ProjekDetailSegue, sender: self)
    }
}








