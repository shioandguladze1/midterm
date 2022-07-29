//
//  EnterUserController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import UIKit

class EnterUserController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    var delegate: UserNameSavedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onEnterUserName(_ sender: Any) {
        let userName = userNameTextField.getText()
        if userName.count <= 6 {
            showAlertWithOkButton(title: "Error", body: "User name length should be more than 6")
        }else{
            UserDefaults.standard.set(userName, forKey: userNameKey)
            UserDefaults.standard.set(UUID().uuidString, forKey: userUUIDdKey)
            delegate?.onUserNameSaved(userName: userName)
            dismiss(animated: true)
        }
    }
    
}
