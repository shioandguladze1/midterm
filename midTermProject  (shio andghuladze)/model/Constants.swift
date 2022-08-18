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
    let imageUrl = UserDefaults.standard.string(forKey: userImageUrlKey)
    if currentUserName != nil && currentUserUUID != nil && imageUrl != nil{
        return User(name: currentUserName!, UUID: currentUserUUID!, imageUrl: imageUrl!)
    }
    return nil
}()

let userNameKey = "userName"
let userUUIDdKey = "userNameUid"
let userImageUrlKey = "userImageUrl"

// firebase keys
let chatsDirKey = "chats"
let usersDirKey = "users"
let userPicturesDirKey = "userPictures/"
