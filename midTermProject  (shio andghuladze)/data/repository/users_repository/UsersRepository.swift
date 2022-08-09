//
//  UsersRepository.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 09.08.22.
//

import Foundation
import FirebaseDatabase

protocol UsersRepository{
    
    func saveUser(user: User, completionBlock: @escaping (Error?, DatabaseReference)-> Void)
    
    func observeOnUsers(block: @escaping ([User])-> Void)
    
}
