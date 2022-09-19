//
//  ChatsTableViewCell.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import UIKit

class ChatsTableViewCell: UITableViewCell, TableViewAdapterCell {
    typealias T = Chat
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak private var chatTitleLabel: UILabel!
    @IBOutlet weak var userImageIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var lastMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = (frame.height - 6) / 2
        selectionStyle = .none
    }
    
    func setUp(data: Chat?){
        guard let data = data else {
            return
        }

        chatTitleLabel.text = data.users.getChatTitle()
        if let lastMessage = data.messages.last{
            var sender = lastMessage.sender.UUID == UserDefaults.standard.user?.UUID ? "you" : lastMessage.sender.name
            sender += ": "
            lastMessageLabel.text = sender + lastMessage.text
        }
        configureChatImage(users: data.users)
    }
    
    func configureChatImage(users: [User]){
        let otherUsers = users.filter { $0.UUID != UserDefaults.standard.user?.UUID }
        if otherUsers.count == 1 {
            userImageIndicator.startAnimating()
            NetworkManger.getImage(imageUrl: otherUsers[0].imageUrl, imageView: userImageView, placeHolder: UIImage(systemName: "person.fill")) {[weak self] in
                self?.userImageView.contentMode = .scaleAspectFill
                self?.userImageIndicator.stopAnimating()
            }
        }
    }
    
}
