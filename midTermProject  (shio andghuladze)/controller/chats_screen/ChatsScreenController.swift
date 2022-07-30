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
    let uuid = UserDefaults.standard.string(forKey: userUUIDdKey) ?? ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    private func setUpTableView(){
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
            ], messages: [Message(text: "asdasdasdas", sender: User(name: "user2", UUID: uuid, isActive: "")), Message(text: "asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdassdas", sender: User(name: "user2", UUID: "2", isActive: "")), Message(text: "asdsadasd", sender: User(name: "user2", UUID: "2", isActive: ""))])
        ]
        
        adapter = TableViewAdapter(tableView: chatsTableView, cellIdentifier: "ChatsTableViewCell", rowHeight: 50)
        adapter?.setData(data: data)
        adapter?.onCellClick = navigateToChat
    }
    
    private func navigateToChat(chat: Chat){
        navigateToController(identifier: "MessagesController"){ (vc: MessagesController) in
            vc.messages = chat.messages
            vc.title = chat.users.getChatTitle(currentUserUUID: uuid)
        }
    }
    
}
