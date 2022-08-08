//
//  Constants.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import Foundation

private var currentUser: User? = nil

func getCurrentUserRef()-> User{
    if currentUser == nil{
        let currentUserName = UserDefaults.standard.string(forKey: userNameKey)
        let currentUserUUID = UserDefaults.standard.string(forKey: userUUIDdKey)
        if currentUserName != nil && currentUserUUID != nil {
            currentUser = User(name: currentUserName!, UUID: currentUserUUID!)
        }
    }
    return currentUser!
}

let userNameKey = "userName"
let userUUIDdKey = "userNameUid"

// firebase keys
let chatsDirKey = "chats"
