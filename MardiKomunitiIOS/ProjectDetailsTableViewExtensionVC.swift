//
//  ProjectDetailsTableViewExtensionVC.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 23/02/2018.
//  Copyright © 2018 com.ingeniworks. All rights reserved.
//

import UIKit

extension ProjectDetailsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == aktivitiTV {
            return sectionHeader.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == aktivitiTV {
            return sectionHeader[section]
        } else if tableView == pegawaiTV {
            return "Senarai nama pegawai"
        } else if  tableView == petaniTV {
            return "Senarai nama petani"
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == aktivitiTV || tableView == pegawaiTV || tableView == petaniTV {
            return 20.0
        } else {
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == aktivitiTV {
            if section == 0 {
                return expandedHeaderName.count
            } else {
                return 1
            }
        } else if tableView == pegawaiTV {
            
            return 1
        } else if tableView == petaniTV {
            
            return enrolls.count
        } else {
            
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        if tableView == aktivitiTV {
            
            if section == 0 {
                
                let groupName = expandedHeaderName[indexPath.row].0
                
                let cell = tableView.dequeueReusableCell(withIdentifier: ProjekIdentifier.ExpandableInfoCell, for: indexPath) as! ExpandableInfoCell
                let index = indexPath.row
                
                if index == 0 {
                    cell.updateView(groupName, content: sektorInfo)
                } else if index == 1 {
                    cell.updateView(groupName, content: subSektorInfo)
                } else if index == 2 {
                    cell.updateView(groupName, content: komuditiGroupInfo)
                } else if index == 3 {
                    cell.updateView(groupName, content: komuditiInfo)
                }
                cell.selectionStyle = .none
                
                return cell
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: ProjekIdentifier.LocationActivityCell, for: indexPath) as! LokasiAktivitiCell
                
                return cell
            }
        } else if tableView == petaniTV {
            
            if enrolls.count > 0 {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: ProjekIdentifier.PetaniTableViewCell, for: indexPath) as! PetaniInfoTableViewCell
                
                cell.selectionStyle = .none
                if let name = enrolls[indexPath.row].name {
                    cell.updateUI(withName: name)
                }
                
                return cell
            } else {
                return createErrorCell(withMessage: "Tiada petani buat masa ini.", tableView: tableView, indexPath: indexPath)
            }
        } else if tableView == pegawaiTV {
            
            return createErrorCell(withMessage: "Tiada pegawai buat masa ini.", tableView: tableView, indexPath: indexPath)
        }
        
        return UITableViewCell()
    }
    
    func createErrorCell(withMessage message: String, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageIdentifier.ErrorCell, for: indexPath) as! ErrorCell
        cell.selectionStyle = .none
        cell.errorMessage = message
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == aktivitiTV {
            if indexPath.section == 0 {
                expandedHeaderName[indexPath.row].1 = !expandedHeaderName[indexPath.row].1
                aktivitiTV.beginUpdates()
                aktivitiTV.reloadRows(at: [indexPath], with: .automatic)
                aktivitiTV.endUpdates()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == aktivitiTV {
            if indexPath.section == 0 {
                if expandedHeaderName[indexPath.row].1 {
                    return UITableViewAutomaticDimension
                } else {
                    return 40.0
                }
            } else {
                return 44.0
            }
        } else if tableView == pegawaiTV {
            
            return pegawaiTV.frame.height
        } else if tableView == petaniTV {
            
            return 60.0
        } else {
            
            return 100.0
        }
    }
}
