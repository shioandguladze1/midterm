//
//  UsersTableViewCell.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import UIKit

class UsersTableViewCell: UITableViewCell, TableViewAdapterCell {
    typealias T = String
    @IBOutlet weak var userNameLabel: UILabel!
    
    func setUp(data: String?) {
        userNameLabel.text = data
    }
    
}
