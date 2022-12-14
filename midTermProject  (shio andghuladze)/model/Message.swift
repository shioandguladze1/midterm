//
//  Message.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import Foundation

struct Message: Codable{
    var id: String = UUID().uuidString
    var sendingTime: Double = Date.now.timeIntervalSince1970
    let text: String
    let sender: User
    let parentChatId: String
}
