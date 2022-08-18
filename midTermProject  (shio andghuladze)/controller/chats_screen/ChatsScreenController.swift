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
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    private var adapter: TableViewAdapter<Chat, ChatsTableViewCell>?
    private let viewModel = ChatsControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        observeToChats()
        setUpUserBar()
        imageActivityIndicator.hidesWhenStopped = true
    }
    
    private func setUpUserBar(){
        userImageView.layer.borderWidth = 1
        userImageView.layer.borderColor = CGColor(red: 0, green: 0, blue: 255, alpha: 1)
        userImageView.layer.cornerRadius = 25
        
        guard let user = currentUser else {
            showAlertWithOkButton(title: "Error", body: "There was error loading user data")
            navigateToController(identifier: "LogInViewController") { (c: UIViewController) in }
            return
        }
        
        imageActivityIndicator.startAnimating()
        userNameLabel.text = user.name
        getImage(imageUrl: user.imageUrl) { [weak self] r in
            parseResult(result: r) { (image: UIImage) in
                DispatchQueue.main.async {
                    self?.userImageView.image = image
                    self?.imageActivityIndicator.stopAnimating()
                }
            } onError: { [weak self] message in
                print(message)
                self?.showAlertWithOkButton(title: "Error", body: "Could not load user image")
                self?.imageActivityIndicator.stopAnimating()
            }
        }
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
    
    @IBAction func logOut(_ sender: Any) {
        viewModel.logOut()
        navigateToController(identifier: "LogInViewController") { (c: UIViewController) in}
    }
    
}
