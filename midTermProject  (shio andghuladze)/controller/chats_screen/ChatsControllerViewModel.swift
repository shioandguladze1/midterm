//
//  ChatsControllerViewModel.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 08.08.22.
//

import Foundation

class ChatsControllerViewModel{
    private let authRepository: AuthRepository = AuthRepositoryImpl()
    
    init(){
        observeUserChats()
    }
    
    private let chatsRepository: ChatsRepository = ChatsRepositoryImpl()
    let chatsLiveData = LiveData<[Chat]>()
    
    func observeUserChats(){
        chatsRepository.observeUserChats { chats in
            if let user = UserDefaults.standard.user {
                let userChats = chats.filter { $0.id.contains(user.UUID) }
                self.chatsLiveData.setData(data: userChats)
            }
        }
    }
    
    func logOut(){
        UserDefaults.standard.user = nil
        authRepository.signOut()
    }
    
}
