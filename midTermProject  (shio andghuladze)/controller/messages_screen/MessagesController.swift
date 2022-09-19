//
//  MessagesController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 25.07.22.
//

import UIKit

class MessagesController: BaseViewController {
    @IBOutlet weak var messagesTableview: UITableView!
    private var adapter: TableViewAdapter<Message, MessageCell>?
    var chatMembers: [User] = []
    @IBOutlet weak var messageTextField: UITextField!
    let viewModel = MessagesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAdapter()
        observeToMessages()
    }
    
    private func setUpAdapter(){
        messagesTableview.separatorStyle = .none
        adapter = TableViewAdapter(tableView: messagesTableview, cellIdentifier: "MessageCell", rowHeight: UITableView.automaticDimension)
    }
    
    private func observeToMessages(){
        viewModel.observeToCurrentChat(chatMembers: chatMembers)
        let observer = Observer<Chat>{[weak self] chat in
            self?.adapter?.setData(data: chat.messages)
            self?.scrollToBottom(lastIndex: chat.messages.count - 1)
        }
        viewModel.currentChatLiveData.addObserver(observer: observer, lifeCycle: controllerLifecycle)
    }

    @IBAction func onSendButtonClick(_ sender: Any) {
        if !messageTextField.getText().isEmpty{
            viewModel.sendMessage(message: messageTextField.getText(), chatMembers: chatMembers)
            messageTextField.text = ""
        }
    }
    
    private func scrollToBottom(lastIndex: Int){
        if lastIndex > 0 {
            messagesTableview.scrollToRow(at: IndexPath(row: lastIndex, section: 0), at: .bottom, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}
