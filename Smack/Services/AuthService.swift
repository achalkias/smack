//
//  AuthService.swift
//  Smack
//
//  Created by Apostolos Chalkias on 19/08/2017.
//  Copyright © 2017 Apostolos Chalkias. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {
    
    //Create singleton
    static let instance = AuthService()
    
    //Create defaults to store data
    let defaults = UserDefaults.standard
    
    //Create getters and setters
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, passworrd: String, completion: @escaping CompletionHandler) {
        
        //Store email to lowerCase
        let lowerCaseEmail = email.lowercased()
        
        //Create a json objects
        let header = [
            "Content-Type": "application/json; charset=utf-8"]
        
        let body: [String: Any] = ["email": lowerCaseEmail, "password": passworrd]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            
            if response.result.error == nil {
                   completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
     
        
    }
    
    
}
