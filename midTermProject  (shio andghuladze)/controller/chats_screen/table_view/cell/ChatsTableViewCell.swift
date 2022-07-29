//
//  ChatsTableViewCell.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import UIKit

class ChatsTableViewCell: UITableViewCell, TableViewAdapterCell {
    typealias T = Chat
    
    @IBOutlet weak private var chatTitleLabel: UILabel!
    @IBOutlet weak private var lastMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUp(data: Chat?){
        selectionStyle = .none
        let currentUserUUID = UserDefaults.standard.string(forKey: userUUIDdKey) ?? ""
        chatTitleLabel.text = getChatTitle(users: data?.users, currentUserUUID: currentUserUUID)
        if let lastMessage = data?.messages.last{
            var sender = lastMessage.sender.UUID == currentUserUUID ? "you" : lastMessage.sender.name
            sender += ": "
            lastMessageLabel.text = sender + lastMessage.text
        }
    }
        
    private func getChatTitle(users: [User]?, currentUserUUID: String)-> String{
        var title = ""
        users?.forEach{user in
            if currentUserUUID != user.UUID{
                title += user.name + ", "
            }
        }
        let index = title.lastIndex(of: ",")!
        return String(title[..<index])
    }
    
}
