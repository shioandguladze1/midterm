//
//  RegistrationViewModel.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 17.08.22.
//

import Foundation
import FirebaseAuth

class RegistrationViewModel{
    private let semaphore = DispatchSemaphore(value: 1)
    private let usersRepository: UsersRepository = UsersRepositoryImpl()
    private let authRepository: AuthRepository = AuthRepositoryImpl()
    private let validator = CredentialsValidator.shared
    let errorLiveData = LiveData<String>()
    
    private var user: FirebaseAuth.User?
    private var imagePath: String?
    
    func registerUser(userName: String, email: String, password: String, imageLocalUrl: String, repeatedPassword: String, onFinish: @escaping ()-> Void){
        DispatchQueue.global().async {

            guard self.validator.validateDataNotEmpty(data: [userName, email, password, imageLocalUrl]) else {
                self.errorLiveData.setData(data: "Fields are empty")
                return
            }

            guard self.validator.validateUserName(userName: userName) else {
                self.errorLiveData.setData(data: "User name should contain at least 6 characters")
                return
            }

            guard self.validator.validatePassword(password: password) else {
                self.errorLiveData.setData(data: "Passowrd should contain at least 6 characters")
                return
            }
            
            guard password == repeatedPassword else {
                self.errorLiveData.setData(data: "Passowrds do not match")
                return
            }
            
            self.createUserAccount(email: email, password: password)
            self.uploadUserImage(imageUrl: imageLocalUrl)
            self.saveUserData(userName: userName)
            self.saveInfoLocally(userName: userName, onFinish: onFinish)
        }
    }
    
    private func createUserAccount(email: String, password: String){
        semaphore.wait()
        authRepository.createUser(email: email, password: password) { r in
            
            parseResult(result: r) { (user: FirebaseAuth.User) in
                self.user = user
                self.semaphore.signal()
            } onError: { message in
                self.errorLiveData.setData(data: message)
                self.semaphore.signal()
            }
    
        }
    }
    
    private func uploadUserImage(imageUrl: String){
        semaphore.wait()
        
        guard let user = user else {
            self.semaphore.signal()
            return
        }
        
        usersRepository.uploadUserImage(userUid: user.uid, url: imageUrl) { r in
         
            parseResult(result: r) { (url: String) in
                self.imagePath = url
                self.semaphore.signal()
            } onError: { message in
                self.errorLiveData.setData(data: message)
                self.authRepository.deleteUser(user: user)
                self.semaphore.signal()
            }
            
        }
    }
    
    private func saveUserData(userName: String){
        semaphore.wait()
        
        guard let user = user else {
            self.semaphore.signal()
            return
        }
        
        guard let imagePath = imagePath else {
            self.semaphore.signal()
            return
        }
                
        let userInstance = User(name: userName, UUID: user.uid, imageUrl: imagePath)
        usersRepository.saveUser(user: userInstance) { r in
            
            parseResult(result: r) { (r: Void) in
                self.semaphore.signal()
            } onError: { message in
                self.errorLiveData.setData(data: message)
                let name = (imagePath as NSString).lastPathComponent
                self.usersRepository.deleteUserImage(pictureName: name)
                self.authRepository.deleteUser(user: user)
                self.semaphore.signal()
            }
            
        }
    }
    
    private func saveInfoLocally(userName: String, onFinish: @escaping ()-> Void){
        semaphore.wait()
        
        guard let user = user else {
            semaphore.signal()
            return
        }
        
        guard let imagePath = imagePath else {
            semaphore.signal()
            return
        }

        UserDefaults.standard.user = User(name: userName, UUID: user.uid, imageUrl: imagePath)
        onFinish()
        semaphore.signal()
    }
    
}
