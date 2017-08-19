//
//  ChatVC.swift
//  Smack
//
//  Created by Apostolos Chalkias on 18/08/2017.
//  Copyright © 2017 Apostolos Chalkias. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var channelNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add a target to menu button
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)) , for: .touchUpInside)
        
        //Add a gesture recognizer to view to close and open the menu on drag
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANEG, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANEG, object: nil)
            })
            MessageService.instance.findAllChannel(completion: { (success) in
                
            })
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            //get channel
            onLoginGetMessages()
        } else {
            channelNameLbl.text = "Please Log In"
        }
    }

    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        //Get the channel name
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        //Change the chanelName
        channelNameLbl.text = "#\(channelName)"
        //Get the channel messages
        getMessages()
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                //If there is at least 1 channel then it will be preselected on chatvc
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text = "No channels yet!"
                }
            }
        }
    }
    
    func getMessages() {
        //Get channel id
        guard let channelId = MessageService.instance.selectedChannel?._id else {return}
        //Get messages based on channel id
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                
            }
        }
    }
    
}
