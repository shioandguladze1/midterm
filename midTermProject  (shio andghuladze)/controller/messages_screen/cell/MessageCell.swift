//
//  MessageCell.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 30.07.22.
//

import UIKit

class MessageCell: UITableViewCell, TableViewAdapterCell {
    typealias T = Message
    private lazy var messageLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    func setUp(data: Message?) {
        if subviews.count > 0 { resetConstraints() }
        setUpLabel()
        if let currentUserUUID = UserDefaults.standard.user?.UUID{
            if data?.sender.UUID == currentUserUUID{ setUpAsSent() } else { setUpAsReceived() }
        }
        messageLabel.text = data?.text
        nameLabel.text = data?.sender.name
    }
    
    private func setUpLabel(){
        nameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameLabel.font = nameLabel.font.withSize(13)
        nameLabel.textColor = .darkGray
        
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.preferredMaxLayoutWidth = frame.width * 0.8
        messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        messageLabel.layer.cornerRadius = 5
        messageLabel.layer.masksToBounds = true
        messageLabel.paddingHorizontal = 5
        messageLabel.paddingVertical = 3
    }
    
    private func setUpAsSent(){
        print("sent")
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        messageLabel.backgroundColor = .systemBlue
        
        nameLabel.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: -3).isActive = true
    }
    
    private func setUpAsReceived(){
        print("received")
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        messageLabel.backgroundColor = .lightGray
        
        nameLabel.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: 3).isActive = true
    }
    
    private func resetConstraints(){
        messageLabel.removeFromSuperview()
        nameLabel.removeFromSuperview()
        addSubview(messageLabel)
        addSubview(nameLabel)
    }
}

