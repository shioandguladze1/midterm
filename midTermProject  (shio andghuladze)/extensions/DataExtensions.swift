//
//  DataExtensions.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 25.08.22.
//

import Foundation

extension UserDefaults{
    
    var user: User? {
        get {
            let userData = value(forKey: Keys.User.rawValue) as? Data
            guard let userData = userData else {
                return nil
            }
            let user = try? JSONDecoder().decode(User.self, from: userData)
            
            guard let user = user else {
                print("Could not decode user " + String(describing: user))
                return nil
            }
            
            return user
        }
        
        set {
            guard let user = newValue else {
                set(nil, forKey: Keys.User.rawValue)
                return
            }
            
            let data = try? JSONEncoder().encode(user)
            guard let data = data else {
                print("Could not encode user " + String(describing: user))
                return
            }
            set(data, forKey: Keys.User.rawValue)
        }
    }
    
    
    enum Keys: String{
        case User = "currentUser"
    }
}
