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
    static let ProjekMembersCell = "projectMembersCell"
    static let ProjekLocationCell = "projectLocationCell"
    static let ProjekStatusCell = "projectStatusCell"
    static let ProjekDescriptionCell = "projectDescriptionCell"
    static let ProjekDetailSegue = "projekDetailsSegue"
    static let ExpandableInfoCell = "expandableInfoCell"
    static let LocationActivityCell = "locationActivityCell"
    static let MaklumatAktivitiCell = "maklumatAktivitiCell"
    static let MaklumatPegawaiCell = "maklumatPegawaiCell"
    static let MaklumatPetaniCell = "maklumatPetaniCell"
    static let PetaniTableViewCell = "petaniCell"
    static let AktivitiTableViewCell = "aktivitiCell"
    static let PegawaiTableViewCell = "pegawaiCell"
}

class ProjectTVC: UITableViewController {
    
    var projeksData = [Projeks]()
    var spinner: LoadingSpinner!
    var isError = false
    var errorMessage = "Tiada data."
    var isRefreshMode = false
    
    var segueIdentifier: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner = LoadingSpinner(view: self.view, isNavBar: true)
        configureTableView()
        configureRefreshControl()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let appDel = AppDelegate.temporaryData as? String
        {
            let rightButton: UIBarButtonItem = UIBarButtonItem.init(title: "Batal", style: UIBarButtonItemStyle.plain, target: self, action: #selector(closeWindow(sender:)))
            
            self.navigationItem.rightBarButtonItem = rightButton
            
            self.segueIdentifier = appDel
        }
        populateData()
    }
    
    func configureTableView() {
        
        tableView.separatorStyle = .none
        if(self.tabBarController != nil){
            tableView.contentInset = UIEdgeInsetsMake(0, 0, (tabBarController?.tabBar.frame.height)!, 0)
        }
        
        let nibName = UINib(nibName: "ErrorCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: MessageIdentifier.ErrorCell)
        
    }
    
    func configureRefreshControl() {
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshedData(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl!)
        }
    }
    
    //func called, bila guna untuk refresh.
    @objc func refreshedData(_ sender: Any) {
        isError = false
        isRefreshMode = true
        projeksData.removeAll()
        populateData()
    }
    
    func populateData() {
        
        let projek = Projeks()
        
        if ZNetwork.isConnectedToNetwork() {
            if !isRefreshMode { spinner.setLoadingScreen() }
            isError = false
            isRefreshMode = false
            if projeksData.count <= 0 {
                print("Masuk dalam tiada data")
                projek.fetchProjek { (data, responses) in
                    
                    DispatchQueue.main.async {
                        
                        self.spinner.removeLoadingScreen()
                        
                        guard responses == nil else {
                            self.isError = true
                            self.errorMessage = responses!
                            self.stopRefreshing()
                            self.tableView.reloadData()
                            return
                        }
                        
                        guard let dataResult = data else { return }
                        self.projeksData = dataResult
                        self.stopRefreshing()
                        self.tableView.reloadData()
                    }
                }
            } else {
                spinner.removeLoadingScreen()
            }
        } else {
            isError = true
            errorMessage = "Tiada internet. Sila periksa rangkaian anda."
            spinner.removeLoadingScreen()
            stopRefreshing()
            self.tableView.reloadData()
        }
    }
    
    func stopRefreshing() {
        if (refreshControl?.isRefreshing)! {
            refreshControl?.endRefreshing()
        }
    }
    
    func closeWindow(sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    var selectedProjek: Projek!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}

extension ProjectTVC {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let count = !isError ? projeksData.count : 1
        return count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if !isError {
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
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height: CGFloat = !isError ? 50.0 : 0.0
        return height
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = !isError ? projeksData[section].projek.count : 1
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        if !isError {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ProjekIdentifier.ProjekCell, for: indexPath) as! ProjekCell
            
            cell.selectionStyle = .none
            cell.updateUI(indexPath.row, projek: projeksData[section].projek[indexPath.row])
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageIdentifier.ErrorCell, for: indexPath) as! ErrorCell
            
            cell.selectionStyle = .none
            cell.errorMessage = errorMessage
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let _ = tableView.cellForRow(at: indexPath) as? ProjekCell {
            
            selectedProjek = projeksData[indexPath.section].projek[indexPath.row]
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ProjectDetailsVC") as! ProjectDetailsVC
            vc.projek = selectedProjek
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isError {
            
            if let tabBarHeight = tabBarController?.tabBar.frame.height {
                return self.view.frame.height - tabBarHeight
            } else {
                return self.view.frame.height
            }
        } else {
            
            return 73.0
        }
    }
}








