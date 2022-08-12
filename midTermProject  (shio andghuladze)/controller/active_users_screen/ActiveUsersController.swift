//
//  ActiveUsersController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 25.07.22.
//

import UIKit

class ActiveUsersController: UIViewController {
    @IBOutlet weak var usersTableView: UITableView!
    private var adapter: TableViewAdapter<User, UsersTableViewCell>?
    private let viewModel = ActiveUsersViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAdapter()
        observeToUsers()
    }
    
    private func setUpAdapter(){
        adapter = TableViewAdapter(tableView: usersTableView, cellIdentifier: "UsersTableViewCell", rowHeight: 50)
        adapter?.onCellClick = navigateToMessages
    }
    
    private func observeToUsers(){
        viewModel.observeActiveUsers()
        let observer = Observer<[User]>(){ users in
            self.adapter?.setData(data: users)
        }
        viewModel.usersLivedata.addObserver(observer: observer)
    }
    
    private func navigateToMessages(data: User){
        if let user = currentUser{
            navigateToController(identifier: "MessagesController") { (vc: MessagesController) in
                vc.title = data.name
                vc.chatMembers = [user, data]
            }
        }
    }

}
