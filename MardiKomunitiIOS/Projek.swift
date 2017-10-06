//
//  Projek.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 06/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class Projek {
    
    var title: String
    var members: String
    
    init(title: String, members: String) {
        
        self.title = title
        self.members = members
    }
    
    
    static func fetchData() -> [[Projek]] {
        
        var tempData = [[Projek]]()
        
        var perikananData = [Projek]()
        perikananData.append(Projek(title: "Projek Penternak Ikan Yu", members: "Adam Levine, Terry Crews, Steve Austion, Dwayne Johnson, Mark Wehlberg"))
        perikananData.append(Projek(title: "Projek Nelayan Kapal Selam", members: "Adam Levine, Terry Crews, Steve Austion, Dwayne Johnson, Mark Wehlberg"))
        perikananData.append(Projek(title: "Projek Udang Galah", members: "Adam Levine, Terry Crews, Steve Austion, Dwayne Johnson, Mark Wehlberg"))
        perikananData.append(Projek(title: "Projek Pembenihan Ikan Sturgeon", members: "Adam Levine, Terry Crews, Steve Austion, Dwayne Johnson, Mark Wehlberg"))
        perikananData.append(Projek(title: "Projek Minyak Lintah", members: "Adam Levine, Terry Crews, Steve Austion, Dwayne Johnson, Mark Wehlberg"))
        
        var tanamanData = [Projek]()
        tanamanData.append(Projek(title: "Projek Jagung", members: "Bill Skarsgård, Jaeden Lieberher, Finn Wolfhard, Sophia Lillis"))
        tanamanData.append(Projek(title: "Projek Kelapa Laut", members: "Bill Skarsgård, Jaeden Lieberher, Finn Wolfhard, Sophia Lillis"))
        tanamanData.append(Projek(title: "Projek Kurma Imba", members: "Bill Skarsgård, Jaeden Lieberher, Finn Wolfhard, Sophia Lillis"))
        
        var ternakanData = [Projek]()
        ternakanData.append(Projek(title: "Projek Penternakan Kuda Belang", members: "Taron Egerton, Colin Firth, Mark Strong, Channing Tatum"))
        ternakanData.append(Projek(title: "Projek Sarang Burung", members: "Taron Egerton, Colin Firth, Mark Strong, Channing Tatum"))
        ternakanData.append(Projek(title: "Projek Ayam KFC", members: "Taron Egerton, Colin Firth, Mark Strong, Channing Tatum"))
        ternakanData.append(Projek(title: "Projek Lembu", members: "Taron Egerton, Colin Firth, Mark Strong, Channing Tatum"))
        
        tempData.append(perikananData)
        tempData.append(tanamanData)
        tempData.append(ternakanData)
        
        return tempData
    }
}













