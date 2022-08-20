//
//  AuthRepository.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 12.08.22.
//

import Foundation
import FirebaseAuth

protocol AuthRepository{
    
    func createUser(email: String, password: String, onResult: @escaping (Result)-> Void)
    
    func signOut()
    
    func deleteUser(user: FirebaseAuth.User)
    
    func logIn(email: String, password: String, onResult: @escaping (Result)-> Void)
        
}
