//
//  UsersRepository.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 09.08.22.
//

import Foundation
import FirebaseDatabase

protocol UsersRepository{
    
    func uploadUserImage(userUid: String, url: String, onResult: @escaping (Result)-> Void)
    
    func getUserInfo(userUid: String, onResult: @escaping (Result)-> Void)
    
    func deleteUserImage(pictureName: String)
    
    func saveUser(user: User, onResult: @escaping (Result)-> Void)
    
    func observeOnUsers(block: @escaping ([User])-> Void)
    
}
