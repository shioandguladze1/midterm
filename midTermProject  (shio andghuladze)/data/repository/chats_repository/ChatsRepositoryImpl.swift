//
//  ChatsRepositoryImpl.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 08.08.22.
//

import Foundation
import FirebaseDatabase

class ChatsRepositoryImpl: ChatsRepository{
    let ref = Database.database().reference()
    
    func observeUserChats(closure: @escaping ([Chat])-> Void) {
        ref.child(chatsDirKey).observe(.value){ snapshot in
            let chats = snapshot.children.convertToObjectArray(type: Chat.self)
            closure(chats)
        }
    }
    
    func updateChat(chat: Chat) {
        ref.child(chatsDirKey).child(chat.id).setValue(chat.toDictionary())
    }
    
    func observeChatMessages(chatId: String, closure: @escaping (Chat)-> Void) {
        ref.child(chatsDirKey).child(chatId).observe(.value){ snapshot in
            if let chat = snapshot.toObject(type: Chat.self){
                closure(chat)
            }
        }
    }
}
