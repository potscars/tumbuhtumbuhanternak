//
//  MessageDetailsExtension.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 04/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

extension MessageDetailsVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionHeader.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let index = indexPath.row
        
        if section == 0 {
            
            if index == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: MessageIdentifier.MessageMemberCell, for: indexPath) as! MembersCell
                cell.selectionStyle = .none
                return cell
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: MessageIdentifier.MessageContentCell, for: indexPath) as! ContentCell
                cell.selectionStyle = .none
                return cell
            }
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MessageIdentifier.MessageRepliedCell, for: indexPath) as! RepliedCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let cell = cell as? MembersCell {
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            return 150
        } else {
            
            return UITableViewAutomaticDimension
        }
    }
}

extension MessageDetailsVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageIdentifier.MessageMemberCollectionCell, for: indexPath) as! MembersCollectionCell
        cell.updateUI()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4)
        
        return CGSize(width: 90.0, height: (145.0 - 8))
    }
}
