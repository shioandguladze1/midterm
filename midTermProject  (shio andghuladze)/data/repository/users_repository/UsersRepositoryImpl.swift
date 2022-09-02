//
//  UsersRepositoryImpl.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 09.08.22.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class UsersRepositoryImpl: UsersRepository{
    static let shared: UsersRepository = UsersRepositoryImpl()
    
    let ref = Database.database().reference()
    let storage = Storage.storage().reference()
    
    func uploadUserImage(userUid: String, url: String, onResult: @escaping (Result)-> Void){
        guard let imageUrl = URL(string: url) else {
            onResult(ErrorResult(errorMessage: "Invalid Url"))
            return
        }
        
        let pictureName = (url as NSString).lastPathComponent
        let ref = storage.child(userPicturesDirKey + userUid + "/" + pictureName)
        
        ref.putFile(from: imageUrl) { metadata, error in
            
            ref.downloadURL { url, error in
                NetworkManger.generateResult(data: url?.absoluteString, error: error, onResult: onResult)
            }
            
        }
        
    }
    
    func getUserInfo(userUid: String, onResult: @escaping (Result) -> Void) {
        ref.child(usersDirKey).child(userUid).getData { error, snapshot in
            let user = snapshot?.toObject(type: User.self) ?? snapshot?.children.convertToObjectArray(type: User.self).filter { $0.UUID == userUid }[0]
            NetworkManger.generateResult(data: user, error: error, onResult: onResult)
        }
    }
    
    func deleteUserImage(pictureName: String){
        let ref = storage.child(userPicturesDirKey + pictureName)
        ref.delete(completion: nil)
    }
    
    func saveUser(user: User, onResult: @escaping (Result)-> Void) {
        guard let dict = user.toDictionary() else {
            onResult(ErrorResult(errorMessage: "Could not convert \(user) to dictionary"))
            return
        }
        
        ref.child(usersDirKey).child(user.UUID).setValue(dict) { error, ref in
            
            NetworkManger.generateResult(data: Void(), error: error, onResult: onResult)
            
        }
    }
    
    func observeOnUsers(block: @escaping ([User]) -> Void) {
        ref.child(usersDirKey).observe(.value){ snapshot in
            let users = snapshot.children.convertToObjectArray(type: User.self)
            block(users)
        }
    }
}
