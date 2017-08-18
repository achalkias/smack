//
//  Constants.swift
//  Smack
//
//  Created by Apostolos Chalkias on 18/08/2017.
//  Copyright © 2017 Apostolos Chalkias. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// URLS
let URL_BASE = "https://achsmack.herokuapp.com/v1"
let URL_REGISTER = "\(URL_BASE)account/register"

// SEGUES
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

//Users Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"