//
//  MessagesController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 25.07.22.
//

import UIKit

class MessagesController: UIViewController {
    @IBOutlet weak var messagesTableview: UITableView!
    private var adapter: TableViewAdapter<Message, MessageCell>?
    var messages: [Message] = []
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAdapter()
    }
    
    private func setUpAdapter(){
        messagesTableview.separatorStyle = .none
        adapter = TableViewAdapter(tableView: messagesTableview, cellIdentifier: "MessageCell", rowHeight: UITableView.automaticDimension)
        adapter?.setData(data: messages)
    }

    @IBAction func onSendButtonClick(_ sender: Any) {
        if !messageTextField.getText().isEmpty{
            sendMessage(message: messageTextField.getText())
            messageTextField.text = ""
        }
    }
    
    private func sendMessage(message: String){
        print("message sent, - " + message)
        if let uuid = UserDefaults.standard.string(forKey: userUUIDdKey) {
            messages.append(Message(text: message, sender: User(name: "shio", UUID: uuid, isActive: "")))
            adapter?.setData(data: messages)
            scrollToBottom()
        }
    }
    
    private func scrollToBottom(){
        if !messages.isEmpty {
            messagesTableview.scrollToRow(at: IndexPath(row: messages.count - 1, section: 0), at: .bottom, animated: true)
        }
    }
}
