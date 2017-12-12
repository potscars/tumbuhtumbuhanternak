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
        return sectionHeader.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        } else {
            let count = respondData.count > 0 ? respondData.count : 1
            return count
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
                cell.message = message
                return cell
            }
        } else {
            
            if respondData.count > 0 {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: MessageIdentifier.MessageRepliedCell, for: indexPath) as! RepliedCell
                cell.selectionStyle = .none
                cell.respond = respondData[indexPath.row]
                return cell
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: MessageIdentifier.MessageErrorCell, for: indexPath) as! ErrorCell
                
                cell.selectionStyle = .none
                
                if isFetched {
                    cell.errorLabel.isHidden = false
                    cell.errorMessage = "Ops. Tiada data."
                } else {
                    tableViewSpinner = LoadingSpinner.init(view: cell.contentView, isNavBar: false)
                    tableViewSpinner.startSpinner()
                    cell.errorLabel.isHidden = true
                }
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let cell = cell as? MembersCell {
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            
            if isFirstTimeLoadMembersCell {
                isFirstTimeLoadMembersCell = !isFirstTimeLoadMembersCell
                spinner = LoadingSpinner.init(view: cell.contentView, isNavBar: false)
                spinner.startSpinner()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            return 142
        } else {
            
            if respondData.count <= 0 {
                return 130
            } else {
                return UITableViewAutomaticDimension
            }
        }
    }
}

extension MessageDetailsVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return respondersName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageIdentifier.MessageMemberCollectionCell, for: indexPath) as! MembersCollectionCell
        
        cell.responderName = respondersName[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(4, 0, 4, 0)
        
        return CGSize(width: 90.0, height: (140.0 - 8))
    }
}





