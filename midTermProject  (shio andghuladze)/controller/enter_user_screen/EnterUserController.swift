//
//  EnterUserController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import UIKit

class EnterUserController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    private let viewModel = EnterUserViewModel()
    var delegate: UserNameSavedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onEnterUserName(_ sender: Any) {
        let userName = userNameTextField.getText()
        if userName.count <= 6 {
            showAlertWithOkButton(title: "Error", body: "User name length should be more than 6")
        }else{
            viewModel.createAndSaveUser(userName: userName, onSuccess: onUserSaved, onError: onError)
        }
    }
    
    private func onUserSaved(userName: String){
        self.delegate?.onUserNameSaved(userName: userName)
        self.dismiss(animated: true)
    }
    
    private func onError(error: Error){
        print(error.localizedDescription)
        self.showAlertWithOkButton(title: "Error", body: "Error creating user, try again")
    }
    
}
