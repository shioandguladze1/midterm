//
//  UsersTableViewCell.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import UIKit

class UsersTableViewCell: UITableViewCell, TableViewAdapterCell {
    typealias T = User
    @IBOutlet weak var userNameLabel: UILabel!
    
    func setUp(data: User?) {
        userNameLabel.text = data?.name
    }
    
}
