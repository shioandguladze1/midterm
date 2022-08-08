//
//  ChatsScreenController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import UIKit
import FirebaseDatabase

class ChatsScreenController: UIViewController {
    @IBOutlet weak var chatsTableView: UITableView!
    private var adapter: TableViewAdapter<Chat, ChatsTableViewCell>?
    let uuid = UserDefaults.standard.string(forKey: userUUIDdKey) ?? ""
    let ref = Database.database().reference()
    
    let users = [
        getCurrentUserRef(),
        User(name: "gio", UUID: "asdasd")
    ]
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        // getData()
        let chats = [
            Chat(users: users, messages: [])
        ]
        adapter?.setData(data: chats)
    }
    
    private func setUpTableView(){
        adapter = TableViewAdapter(tableView: chatsTableView, cellIdentifier: "ChatsTableViewCell", rowHeight: 50)
        adapter?.onCellClick = navigateToChat
    }
    
    private func navigateToChat(chat: Chat){
        navigateToController(identifier: "MessagesController"){ (vc: MessagesController) in
            vc.chatMembers = chat.users
            vc.title = chat.users.getChatTitle(currentUserUUID: uuid)
        }
    }
    
    private func getData(){
        ref.child(chatsDirKey).observe(.value){ snapshot in
            let chats = snapshot.children.convertToObjectArray(type: Chat.self)
            self.adapter?.setData(data: chats)
        }
    }
    
}
