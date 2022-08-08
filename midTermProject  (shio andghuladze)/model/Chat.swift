//
//  Chat.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import Foundation

struct Chat: Decodable{
    let id: String
    let users: [User]
    var messages: [Message]
    
    init(users: [User], messages: [Message]){
        self.users = users
        self.messages = messages
        self.id = users.generateChatId()
    }
    
    func toDictionary()-> NSDictionary{
        return [
            "id": id,
            "users": users.map{ $0.toDictionary() },
            "messages": messages.map{ $0.toDictionary() }
        ]
    }
}
