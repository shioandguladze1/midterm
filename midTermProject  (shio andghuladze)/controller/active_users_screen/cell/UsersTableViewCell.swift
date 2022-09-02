//
//  UsersTableViewCell.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import UIKit

class UsersTableViewCell: UITableViewCell, TableViewAdapterCell {
    typealias T = User
    
    private var cachedImage: UIImage?
    
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
        if let cachedImage = cachedImage {
            userImageView.contentMode = .scaleAspectFill
            userImageView.image = cachedImage
            return
        }
        
        userImageView.contentMode = .scaleAspectFit
        NetworkManger.getImage(imageUrl: user.imageUrl) { r in
            NetworkManger.parseResult(result: r) { (image: UIImage) in
                DispatchQueue.main.async {
                    self.userImageView.contentMode = .scaleAspectFill
                    self.userImageView.image = image
                }
            }
        }
    }
}
