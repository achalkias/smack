//
//  MessageCell.swift
//  Smack
//
//  Created by Apostolos Chalkias on 19/08/2017.
//  Copyright © 2017 Apostolos Chalkias. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userImage: CircleImage!
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    
    @IBOutlet weak var messageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Message) {
        messageLbl.text = message.message
        userNameLbl.text = message.userName
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(componets: message.userAvatarColor)
        
        //Unrwap the time
        guard var isoDate = message.timeStamp else { return }
        //Remove the miliseconds
        let end  = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormater = ISO8601DateFormatter()
        let chatDate = isoFormater.date(from: isoDate.appending("Z"))
        
        let newFormater = DateFormatter()
        newFormater.dateFormat = "MMM d, h:mm a"
        
        if let finalDate  = chatDate {
            let finalDate = newFormater.string(from: finalDate)
            timestampLbl.text = finalDate
        }
        
    }
    
}
