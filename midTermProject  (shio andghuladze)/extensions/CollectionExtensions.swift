//
//  CollectionExtensions.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 30.07.22.
//

import Foundation

extension Array where Element == User{
    
    func getChatTitle(currentUserUUID: String)-> String{
        var title = ""
        forEach{user in
            if currentUserUUID != user.UUID{
                title += user.name + ", "
            }
        }
        let index = title.lastIndex(of: ",")!
        return String(title[..<index])
    }
    
}

