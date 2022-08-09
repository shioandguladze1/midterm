//
//  ChatsControllerViewModel.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 08.08.22.
//

import Foundation

class ChatsControllerViewModel{
    init(){
        observeUserChats()
    }
    
    private let chatsRepository: ChatsRepository = ChatsRepositoryImpl()
    let chatsLiveData = LiveData<[Chat]>()
    
    func observeUserChats(){
        chatsRepository.observeUserChats { chats in
            if let user = currentUser{
                let userChats = chats.filter { $0.id.contains(user.UUID) }
                self.chatsLiveData.setData(data: userChats)
            }
        }
    }
    
}
