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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner = LoadingSpinner(view: self.view, isNavBar: true)
        configureTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let mesej = Mesej()
        
        if messages.count <= 0 {
            spinner.setLoadingScreen()
            mesej.fetchData({ (result, responses) in
                
                guard responses == nil else {
                    //show error message
                    return
                }
                
                guard let mesejResult = result else { return; }
                
                DispatchQueue.main.async {
                    self.messages = mesejResult
                    self.tableView.reloadData()
                    self.spinner.removeLoadingScreen()
                }
            })
        }
    }
    
    func configureTableView() {
        
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120.0
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
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageIdentifier.MessageInboxCell, for: indexPath) as! MessageInboxCell
        
        cell.selectionStyle = .none
        cell.message = messages[indexPath.row]
        
        return cell
    }
}

extension MessageInboxTVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedMessage = messages[indexPath.row]
        performSegue(withIdentifier: MessageIdentifier.GotoMessageDetails, sender: self)
    }
}











