//
//  MessageInboxTVC.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 04/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

struct MessageIdentifier {
    
    static let MessageInboxCell = "messageInboxCell"
    static let MessageMemberCell = "membersCell"
    static let MessageContentCell = "contentCell"
    static let MessageRepliedCell = "repliedCell"
    static let MessageMemberCollectionCell = "membersCollectionCell"
    static let GotoMessageDetails = "gotoMessageDetails"
    static let MessageErrorCell = "errorCell"
}

class MessageInboxTVC: UITableViewController {

    var messages = [Mesej]()
    var spinner: LoadingSpinner!
    let alertController = AlertController()
    var errorMessage = "Tiada data buat ketika ini."
    var isError = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner = LoadingSpinner(view: self.view, isNavBar: true)
        configureTableView()
        configureRefreshControl()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        populateData()
    }
    
    func configureTableView() {
        
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150.0
        
        let nibName = UINib(nibName: "ErrorCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: MessageIdentifier.MessageErrorCell)
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
    
    @objc func refreshedData(_ sender: Any) {
        isError = false
        messages.removeAll()
        populateData()
    }
    
    func populateData() {
        
        let mesej = Mesej()
        
        if ZNetwork.isConnectedToNetwork() {
            spinner.setLoadingScreen()
            isError = false
            if messages.count <= 0 {
                mesej.fetchData({ (result, responses) in
                    DispatchQueue.main.async {
                        
                        self.spinner.removeLoadingScreen()
                        
                        guard responses == nil else {
                            self.errorMessage = responses!
                            self.isError = true
                            self.stopRefreshing()
                            self.tableView.reloadData()
                            return
                        }
                        
                        guard let mesejResult = result else { return; }
                        
                        self.stopRefreshing()
                        self.messages = mesejResult
                        self.tableView.reloadData()
                    }
                })
            } else {
                spinner.removeLoadingScreen()
            }
        } else {
            spinner.removeLoadingScreen()
            isError = true
            errorMessage = "Tiada internet dikesan. Sila periksa rangkaian anda."
            stopRefreshing()
            tableView.reloadData()
        }
    }
    
    func stopRefreshing() {
        if (refreshControl?.isRefreshing)! {
            refreshControl?.endRefreshing()
        }
    }
    
    var selectedMessage: Mesej!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == MessageIdentifier.GotoMessageDetails {
            
            if let destination = segue.destination as? MessageDetailsVC {
                destination.message = selectedMessage
            }
        }
    }
}

// MARK: - Table view data source
extension MessageInboxTVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = isError ? 1 : messages.count
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if messages.count > 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageIdentifier.MessageInboxCell, for: indexPath) as! MessageInboxCell
            
            cell.selectionStyle = .none
            cell.message = messages[indexPath.row]
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageIdentifier.MessageErrorCell, for: indexPath) as! ErrorCell
            cell.selectionStyle = .none
            cell.errorMessage = errorMessage
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isError {
           return self.view.frame.height - (tabBarController?.tabBar.frame.height)!
        } else {
            return UITableViewAutomaticDimension
        }
    }
}

extension MessageInboxTVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let _ = tableView.cellForRow(at: indexPath) as? MessageInboxCell {
            selectedMessage = messages[indexPath.row]
            performSegue(withIdentifier: MessageIdentifier.GotoMessageDetails, sender: self)
        }
    }
}











