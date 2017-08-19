//
//  UserDataService.swift
//  Smack
//
//  Created by Apostolos Chalkias on 19/08/2017.
//  Copyright © 2017 Apostolos Chalkias. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    //Variables
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name:String ) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    func returnUIColor(componets: String) -> UIColor {
        //Get the string array color and change id to ui color
        let scanner = Scanner(string: componets)
        
        let skipped = CharacterSet(charactersIn: "[], ")
        
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r,g,b,a : NSString?
        
        //Get red value
       scanner.scanUpToCharacters(from: comma, into: &r)
        //Get green value
        scanner.scanUpToCharacters(from: comma, into: &g)
        //Get blue value
        scanner.scanUpToCharacters(from: comma, into: &b)
        //Get alpha value
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        //Create a default
        let defaultColor = UIColor.lightGray
        
        //Unwrap values
        guard let rUnwrapped = r else {return defaultColor}
        guard let gUnwrapped = g else {return defaultColor}
        guard let bUnwrapped = b else {return defaultColor}
        guard let aUnwrapped = a else {return defaultColor}

        //Convert them to cgfloat
        let rfloat = CGFloat(rUnwrapped.doubleValue)
         let gfloat = CGFloat(gUnwrapped.doubleValue)
         let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        //Create the ui color 
        let newUicolor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUicolor
    }
    
    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }
    
}
