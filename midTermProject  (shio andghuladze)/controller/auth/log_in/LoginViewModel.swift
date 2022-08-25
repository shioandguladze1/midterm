//
//  LoginViewModel.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 17.08.22.
//

import Foundation

class LoginViewModel{
    private let semaphore = DispatchSemaphore(value: 1)
    private let authRepository: AuthRepository = AuthRepositoryImpl()
    private let usersRepository: UsersRepository = UsersRepositoryImpl()
    private let validator = CredentialsValidator()
    private var userUid: String?
    
    let errorLiveData = LiveData<String>()
    
    func logIn(email: String, password: String, onSuccess: @escaping ()-> Void){
        DispatchQueue.global().async {
            self.getUser(email: email, password: password)
            self.updateUserInstance(onSuccess: onSuccess)
        }
    }
    
    private func getUser(email: String, password: String){
        semaphore.wait()
        
        guard validator.validateDataNotEmpty(data: [email, password]) else {
            errorLiveData.setData(data: "Fields are empty")
            semaphore.signal()
            return
        }
        
        guard validator.validatePassword(password: password) else {
            errorLiveData.setData(data: "Password should contain at least 6 characters")
            semaphore.signal()
            return
        }
        
        authRepository.logIn(email: email, password: password) { r in
            parseResult(result: r) { (userUid: String) in
                self.userUid = userUid
                self.semaphore.signal()
            } onError: { message in
                self.errorLiveData.setData(data: message)
                self.semaphore.signal()
            }

        }
    }
    
    private func updateUserInstance(onSuccess: @escaping ()-> Void){
        semaphore.wait()
        
        guard let userUid = userUid else {
            errorLiveData.setData(data: "User not found")
            semaphore.signal()
            return
        }
        
        usersRepository.getUserInfo(userUid: userUid) { r in
            parseResult(result: r) { (user: User) in
                UserDefaults.standard.user = user
                onSuccess()
                self.semaphore.signal()
            } onError: { message in
                self.errorLiveData.setData(data: message)
                self.semaphore.signal()
            }
        }
    }
    
}
