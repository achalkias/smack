//
//  MessageService.swift
//  Smack
//
//  Created by Apostolos Chalkias on 19/08/2017.
//  Copyright © 2017 Apostolos Chalkias. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel : Channel?
    
    
    func findAllChannel(completion: @escaping CompletionHandler){
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                //Get data
                guard let data = response.data else {return}
                
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }
                
                if self.channels.count > 0 {
                    print(self.channels)
                }
                
//                //Get the json array
//                if let json = JSON(data: data).array{
//                    //Loop through and get the channel and add it to channels array
//                    for item in json {
//                        let name  = item["name"].stringValue
//                        let channelDescription = item["descrpition"].stringValue
//                        let id = item["_id"].stringValue
//                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
//                        self.channels.append(channel)
//                    }
//                    completion(true)
//                }
                
                //Swift 4 way
                NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearChannels() {
        //Remove all channels
        channels.removeAll()
    }
    
}
