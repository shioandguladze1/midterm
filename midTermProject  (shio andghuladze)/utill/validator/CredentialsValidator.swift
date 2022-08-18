//
//  CredentialsValidator.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 17.08.22.
//

import Foundation

class CredentialsValidator{
    
    static let shared = CredentialsValidator()
    
    func validateUserName(userName: String)-> Bool{
        return userName.count >= 6
    }
    
    func validatePassword(password: String)-> Bool{
        return password.count >= 6
    }
    
    func validateDataNotEmpty(data: [String])-> Bool{
        for each in data{
            if each.isEmpty { return false }
        }
        return true
    }
}
