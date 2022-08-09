//
//  EnterUserViewModel.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 08.08.22.
//

import Foundation
import FirebaseDatabase

class EnterUserViewModel{
    private let usersRepository: UsersRepository = UsersRepositoryImpl()
    
    func createAndSaveUser(userName: String, onSuccess: @escaping (String)-> Void, onError: @escaping (Error)-> Void){
        let uuid = UUID().uuidString
        UserDefaults.standard.set(userName, forKey: userNameKey)
        UserDefaults.standard.set(uuid, forKey: userUUIDdKey)
        let user = User(name: userName, UUID: uuid)
        usersRepository.saveUser(user: user){ error, _ in
            if error == nil{
                onSuccess(userName)
                currentUser = user
            }else{
                onError(error!)
            }
        }
    }
    
}
