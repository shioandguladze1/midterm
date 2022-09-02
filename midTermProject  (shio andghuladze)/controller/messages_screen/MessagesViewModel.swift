//
//  MessagesViewModel.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 08.08.22.
//

import Foundation

class MessagesViewModel{
    private let chatsRepository = ChatsRepositoryImpl.shared
    
    let currentChatLiveData = LiveData<Chat>()
    
    func sendMessage(message: String, chatMembers: [User]){
        var chat = currentChatLiveData.data
        if chat == nil{
            chat = Chat(users: chatMembers, messages: [])
        }
        if var c = chat{
            let message = Message(text: message, sender: UserDefaults.standard.user!, parentChatId: c.id)
            c.messages.append(message)
            chatsRepository.updateChat(chat: c)
        }
        observeToCurrentChat(chatMembers: chatMembers)
    }
    
    func observeToCurrentChat(chatMembers: [User]){
        chatsRepository.observeChatMessages(chatId: chatMembers.generateChatId()){ chat in
            self.currentChatLiveData.setData(data: chat)
        }
    }
    
}
