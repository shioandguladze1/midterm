//
//  ActiveUsersController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 25.07.22.
//

import UIKit

class ActiveUsersController: UIViewController {
    @IBOutlet weak var usersTableView: UITableView!
    private let data = [
        User(name: "shio", UUID: "@", isActive: ""),
        User(name: "shio", UUID: "@", isActive: ""),
        User(name: "shio", UUID: "@", isActive: ""),
        User(name: "shio", UUID: "@", isActive: ""),
        User(name: "shio", UUID: "@", isActive: "")
    ]
    private var adapter: TableViewAdapter<User, UsersTableViewCell>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAdapter()
    }
    
    private func setUpAdapter(){
        adapter = TableViewAdapter(tableView: usersTableView, cellIdentifier: "UsersTableViewCell", rowHeight: 50)
        adapter?.setData(data: data)
        adapter?.onCellClick = navigateToMessages
    }
    
    private func navigateToMessages(data: User){
        navigateToController(identifier: "MessagesController") { (vc: MessagesController) in
            vc.title = data.name
        }
    }

}
