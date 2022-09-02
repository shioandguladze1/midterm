//
//  ChatsTableViewCell.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import UIKit

class ChatsTableViewCell: UITableViewCell, TableViewAdapterCell {
    typealias T = Chat
    
    private var cachedImage: UIImage?
    
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
        if let cachedImage = cachedImage {
            userImageView.contentMode = .scaleAspectFill
            userImageView.image = cachedImage
            return
        }
        
        userImageView.contentMode = .scaleAspectFit
        let otherUsers = users.filter { $0.UUID != UserDefaults.standard.user?.UUID }
        if otherUsers.count == 1 {
            userImageView.image = nil
            userImageIndicator.startAnimating()
            userImageView.contentMode = .scaleAspectFill
            NetworkManger.getImage(imageUrl: otherUsers[0].imageUrl) { r in
                NetworkManger.parseResult(result: r) { (image: UIImage) in
                    DispatchQueue.main.async {
                        self.cachedImage = image
                        self.userImageView.image = image
                        self.userImageIndicator.stopAnimating()
                    }
                }
            }
        }
    }
    
}
