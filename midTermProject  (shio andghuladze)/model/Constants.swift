//
//  Constants.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import Foundation

var currentUser: User? = {
    let currentUserName = UserDefaults.standard.string(forKey: userNameKey)
    let currentUserUUID = UserDefaults.standard.string(forKey: userUUIDdKey)
    if currentUserName != nil && currentUserUUID != nil {
        return User(name: currentUserName!, UUID: currentUserUUID!)
    }
    return nil
}()

let userNameKey = "userName"
let userUUIDdKey = "userNameUid"

// firebase keys
let chatsDirKey = "chats"
let usersDirKey = "users"
