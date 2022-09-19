//
//  ActiveUsersController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 25.07.22.
//

import UIKit

class ActiveUsersController: BaseViewController {
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var adapter: TableViewAdapter<User, UsersTableViewCell>?
    private let viewModel = ActiveUsersViewModel()
    private let searchBarDelegate = GeneralSearchBarDelegate<User> { user, searchValue in
        user.name.lowercased().contains(searchValue.lowercased())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observeToUsers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAdapter()
        setUpSearchBar()
    }
    
    private func setUpSearchBar(){
        searchBarDelegate.onValueChanged = {[weak self] users in
            self?.adapter?.setData(data: users)
        }
        searchBar.delegate = searchBarDelegate
    }
    
    private func setUpAdapter(){
        adapter = TableViewAdapter(tableView: usersTableView, cellIdentifier: "UsersTableViewCell", rowHeight: 50)
        adapter?.onCellClick = navigateToMessages
    }
    
    private func observeToUsers(){
        viewModel.observeActiveUsers()
        let observer = Observer<[User]>(){[weak self] users in
            self?.adapter?.setData(data: users)
            self?.searchBarDelegate.updateInitialList(list: users)
        }
        viewModel.usersLivedata.addObserver(observer: observer, lifeCycle: controllerLifecycle)
    }
    
    private func navigateToMessages(data: User){
        if let user = UserDefaults.standard.user{
            navigateToController(identifier: "MessagesController") { (vc: MessagesController) in
                vc.title = data.name
                vc.chatMembers = [user, data]
            }
        }
    }

}
