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
}

class MessageInboxTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageIdentifier.MessageInboxCell, for: indexPath) as! MessageInboxCell
        
        return cell
    }
}

extension MessageInboxTVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: MessageIdentifier.GotoMessageDetails, sender: self)
    }
}











