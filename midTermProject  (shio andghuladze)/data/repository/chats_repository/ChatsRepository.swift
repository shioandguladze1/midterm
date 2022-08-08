//
//  ChatsRepository.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 08.08.22.
//

import Foundation

protocol ChatsRepository {
    
    func observeUserChats(closure: @escaping ([Chat])-> Void)
    
    func updateChat(chat: Chat)
    
    func observeChatMessages(chatId: String, closure: @escaping (Chat)-> Void)
}
