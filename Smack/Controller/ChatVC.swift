//
//  ChatVC.swift
//  Smack
//
//  Created by Apostolos Chalkias on 18/08/2017.
//  Copyright © 2017 Apostolos Chalkias. All rights reserved.
//

import UIKit

class ChatVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    // MARK: Outlets
    
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var channelNameLbl: UILabel!
    
    @IBOutlet weak var MessageTxtBox: UITextField!
  
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var typingUsersLbl: UILabel!
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Bind the view to the keybaord so when it opens the keyboard everything will scroll upside
        view.bindToKeyboard()
        
        tableView.delegate = self
        tableView.dataSource = self
        //Make tableview rows dynamic
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        sendBtn.isHidden = true
        
        let tapToClose = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tapToClose)
        
        
        
        //Add a target to menu button
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)) , for: .touchUpInside)
        
        //Add a gesture recognizer to view to close and open the menu on drag
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANEG, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
        
        SocketService.instance.getChatMessages { (newMessage) in
            if newMessage.channelId == MessageService.instance.selectedChannel?._id
                && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
//        SocketService.instance.getChatMessages { (success) in
//            if success {
//                self.tableView.reloadData()
//                //Scroll to the bottom if needed
//                if MessageService.instance.messages.count > 0 {
//                    //Get the last item index
//                    let endexPath = IndexPath(row: MessageService.instance.messages.count-1, section: 0)
//                    self.tableView.scrollToRow(at: endexPath, at: .bottom, animated: false)
//                }
//            }
//        }
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?._id else {return}
            var names = ""
            var numberOfTypers = 0
          
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingUsersLbl.text = "\(names) \(verb) typing a message"
            }else {
                self.typingUsersLbl.text = ""
            }
            
        }
        
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
            tableView.reloadData()
        }
    }

    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    @objc func handleTap() {
        view.endEditing(true)
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
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func msgBoxEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?._id else {return}
        if MessageTxtBox.text == "" {
            isTyping = false
            sendBtn.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name,channelId)
        } else {
            if isTyping == false {
                sendBtn.isHidden = false
                isTyping = true
                SocketService.instance.socket.emit("startType", UserDataService.instance.name,channelId)
            }
        }
    }
    
    
    @IBAction func sendMessagePresed(_ sender: Any) {
        if (AuthService.instance.isLoggedIn) {
            guard let channelId = MessageService.instance.selectedChannel?._id else {return}
            guard let message = MessageTxtBox.text  else {return}
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                self.MessageTxtBox.text = ""
                self.MessageTxtBox.resignFirstResponder() //Close keyboard
                self.isTyping = false
                self.sendBtn.isHidden = true
                SocketService.instance.socket.emit("stopType", UserDataService.instance.name,channelId)
            })
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell",for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
}
