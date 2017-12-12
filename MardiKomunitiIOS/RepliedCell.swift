//
//  RepliedCell.swift
//  MardiKomunitiIOS
//
//  Created by Hainizam on 04/10/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

class RepliedCell: UITableViewCell {

    @IBOutlet weak var imageFeatured : UIImageView!
    @IBOutlet weak var senderLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var positionLabel : UILabel!
    @IBOutlet weak var contentLabel : UILabel!
    
    //var dateFormatter = DateFormatter()
    
    var respond: Respond! {
        didSet {
            self.updateUI()
        }
    }

    private func updateUI() {
        
        senderLabel.text = respond.responderName
        positionLabel.text = respond.responderCaption
        contentLabel.text = respond.responderMessage
        
        let timeElapsed = dateformatter(dateString: respond.responderPostedDate!)
        dateLabel.text = timeElapsed
        dateLabel.sizeToFit()
        
        imageFeatured.backgroundColor = .green
        imageFeatured.circledView(imageFeatured.frame.width)
        
        ZGraphics().createImageWithLetter(respond.responderName!, imageView: imageFeatured, fontSize: imageFeatured.frame.width / 2)
    }
    
    func dateformatter(dateString: String) -> String {
        
        var currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDateString = formatter.string(from: currentDate)
        currentDate = formatter.date(from: currentDateString)!
        
        let postedDate = formatter.date(from: dateString)!
        print(postedDate)
        
        formatter.dateFormat = "yyyy-MM-dd"
        let postedDateInDate = formatter.string(from: postedDate)
        print(postedDateInDate)
        
        formatter.dateFormat = "h:mm a"
        let postedDateInTime = formatter.string(from: postedDate)
        print(postedDateInTime)
        
        let calendar: Calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: postedDate, to: currentDate)
        print(components)
        
        if components.hour! > 24 {
            return postedDateInDate
        } else if components.hour! > 0 {
            return postedDateInTime
        } else if components.minute! > 1 {
            return "\(components.minute!)m ago"
        } else {
            return "Just Now"
        }
    }
}













