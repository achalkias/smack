//
//  ChannelCell.swift
//  Smack
//
//  Created by Apostolos Chalkias on 19/08/2017.
//  Copyright © 2017 Apostolos Chalkias. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //When the item is selected it will get a white bg
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func  configureCell(channel: Channel)  {
        //Get the title and add it to uilabel
        if  let title = channel.name {
            channelName.text = "#\(title)"
            channelName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
            
            for id in MessageService.instance.unreadChannels {
                if id == channel._id {
                    channelName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
                    
                }
            }
        } else {
             channelName.text = "#N/A"
        }
    }
    

}
