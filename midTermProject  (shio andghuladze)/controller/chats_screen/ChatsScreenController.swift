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
    private let viewModel = ChatsControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        observeToChats()
    }
    
    private func setUpTableView(){
        adapter = TableViewAdapter(tableView: chatsTableView, cellIdentifier: "ChatsTableViewCell", rowHeight: 50)
        adapter?.onCellClick = navigateToChat
    }
    
    private func observeToChats(){
        let observer = Observer<[Chat]>(){ chats in
            self.adapter?.setData(data: chats)
        }
        viewModel.chatsLiveData.addObserver(observer: observer)
    }
    
    private func navigateToChat(chat: Chat){
        navigateToController(identifier: "MessagesController"){ (vc: MessagesController) in
            vc.chatMembers = chat.users
            vc.title = chat.users.getChatTitle()
        }
    }
    
}
