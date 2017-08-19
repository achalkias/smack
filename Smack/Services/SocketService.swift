//
//  SocketService.swift
//  Smack
//
//  Created by Apostolos Chalkias on 19/08/2017.
//  Copyright © 2017 Apostolos Chalkias. All rights reserved.
//

import UIKit
import SocketIO
class SocketService: NSObject {
    
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    //Create socket
    var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: URL_BASE)!)
    
    func enstablishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName: String,channelDescription: String,completion: @escaping CompletionHandler) {
        socket.emit("newChannel", channelName,channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            //Get the created channel
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            //Create channel obj from these variables
            let newChannel  = Channel(_id: channelId, _name: channelName, description: channelDesc, __v: 0)
            //Append to the chanels array
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
}
