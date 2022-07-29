//
//  ActiveUsersController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 25.07.22.
//

import UIKit

class ActiveUsersController: UIViewController {
    @IBOutlet weak var usersTableView: UITableView!
    private let data = ["shio", "ana", "mari", "nia", "levani"]
    private var adapter: TableViewAdapter<String, UsersTableViewCell>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAdapter()
    }
    
    private func setUpAdapter(){
        adapter = TableViewAdapter(tableView: usersTableView, cellIdentifier: "UsersTableViewCell", rowHeight: 50)
        adapter?.setData(data: data)
    }

}
