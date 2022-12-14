//
//  ActiveUsersViewModel.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 09.08.22.
//

import Foundation

class ActiveUsersViewModel{
    private let usersRepository = UsersRepositoryImpl.shared
    let usersLivedata = LiveData<[User]>()
    
    func observeActiveUsers(){
        usersRepository.observeOnUsers { users in
            let usersWithoutCurrentUser = users.filter{ $0.UUID != UserDefaults.standard.user?.UUID }
            self.usersLivedata.setData(data: usersWithoutCurrentUser)
        }
    }
    
}

