//
//  UsersRepositoryImpl.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 09.08.22.
//

import Foundation
import FirebaseDatabase

class UsersRepositoryImpl: UsersRepository{
    let ref = Database.database().reference()
    
    func saveUser(user: User, completionBlock: @escaping (Error?, DatabaseReference)-> Void = {_, _ in}) {
        ref.child(usersDirKey).child(user.UUID).setValue(user.toDictionary(), withCompletionBlock: completionBlock)
    }
    
    func observeOnUsers(block: @escaping ([User]) -> Void) {
        ref.child(usersDirKey).observe(.value){ snapshot in
            let users = snapshot.children.convertToObjectArray(type: User.self)
            block(users)
        }
    }
}
