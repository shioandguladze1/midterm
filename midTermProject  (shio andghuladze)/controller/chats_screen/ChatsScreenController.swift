//
//  ChatsScreenController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import UIKit

class ChatsScreenController: UIViewController {
    @IBOutlet weak var chatsTableView: UITableView!
    private var adapter: TableViewAdapter<Chat, ChatsTableViewCell>?
    let data = [
        Chat(users: [
            User(name: "user1", UUID: "1", isActive: ""),
            User(name: "user2", UUID: "2", isActive: "")
        ], messages: [Message(text: "asdasdasdas", sender: User(name: "user2", UUID: "2", isActive: ""))]),
        Chat(users: [
            User(name: "user1", UUID: "1", isActive: ""),
            User(name: "user2", UUID: "2", isActive: "")
        ], messages: [Message(text: "asdasdasdas", sender: User(name: "user2", UUID: "2", isActive: ""))]),
        Chat(users: [
            User(name: "user1", UUID: "1", isActive: ""),
            User(name: "user2", UUID: "2", isActive: "")
        ], messages: [Message(text: "asdasdasdas", sender: User(name: "user2", UUID: "2", isActive: ""))]),
        Chat(users: [
            User(name: "user1", UUID: "1", isActive: ""),
            User(name: "user2", UUID: "2", isActive: "")
        ], messages: [Message(text: "asdasdasdas", sender: User(name: "user2", UUID: "2", isActive: ""))]),
        Chat(users: [
            User(name: "user1", UUID: "1", isActive: ""),
            User(name: "user2", UUID: "2", isActive: "")
        ], messages: [Message(text: "asdasdasdas", sender: User(name: "user2", UUID: "2", isActive: ""))])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    private func setUpTableView(){
        adapter = TableViewAdapter(tableView: chatsTableView, cellIdentifier: "ChatsTableViewCell", rowHeight: 50)
        adapter?.setData(data: data)
    }
    
}
