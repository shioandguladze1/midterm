//
//  UsersTableViewCell.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import UIKit

class UsersTableViewCell: UITableViewCell, TableViewAdapterCell {
    typealias T = User
        
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = (frame.height - 6) / 2
        selectionStyle = .none
    }
    
    func setUp(data: User?) {
        guard let data = data else {
            return
        }
        
        userNameLabel.text = data.name
        configureUserImage(user: data)
    }
    
    func configureUserImage(user: User){
        NetworkManger.getImage(imageUrl: user.imageUrl, imageView: userImageView, placeHolder: UIImage(systemName: "person.fill")) { [weak self]
            self?.userImageView.contentMode = .scaleAspectFill
        }
    }
}
