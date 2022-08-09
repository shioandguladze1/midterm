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
        chatTitleLabel.text = data?.users.getChatTitle()
        if let lastMessage = data?.messages.last{
            var sender = lastMessage.sender.UUID == currentUser?.UUID ? "you" : lastMessage.sender.name
            sender += ": "
            lastMessageLabel.text = sender + lastMessage.text
        }
    }
    
}
