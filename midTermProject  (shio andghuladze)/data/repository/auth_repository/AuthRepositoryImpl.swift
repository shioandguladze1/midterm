//
//  AuthRepositoryImpl.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 12.08.22.
//

import Foundation
import FirebaseAuth

class AuthRepositoryImpl: AuthRepository{
    
    func createUser(email: String, password: String, onResult: @escaping (Result)-> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            generateResult(data: result?.user, error: error) { r in
                onResult(r)
            }
            
        }
    }
    
    func deleteUser(user: FirebaseAuth.User){
        user.delete()
    }
    
    func logIn(email: String, password: String, onResult: @escaping (Result)-> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            generateResult(data: result?.user.uid, error: error) { r in
                onResult(r)
            }
            
        }
        
    }
    
}
