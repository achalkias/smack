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
let URL_BASE = "https://achsmack.herokuapp.com/v1/"
let URL_REGISTER = "\(URL_BASE)account/register"
let URL_LOGIN = "\(URL_BASE)account/login"
let URL_USER_ADD = "\(URL_BASE)user/add"
let URL_USER_BY_EMAIL = "\(URL_BASE)user/byEmail/"
let URL_GET_CHANNELS = "\(URL_BASE)/channel/"

//COLORS
let smackPurplePlaceHolder = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5)

//NOTIFICATIONS
let NOTIF_USER_DATA_DID_CHANEG = Notification.Name("notifUserDataChange")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNELS_SELECTED = Notification.Name("channelsSelected")

// SEGUES
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//Users Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"]
let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
