//
//  ChatsScreenController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 25.07.22.
//

import UIKit

class BottomNavHostController: UITabBarController, UserNameSavedDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserExists()
    }
    
    func onUserNameSaved(userName: String) {
        
    }
    
    private func checkUserExists(){
        let userName = UserDefaults.standard.string(forKey: userNameKey)
        if userName == nil{
            createUser()
        }
    }
    
    private func createUser(){
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "EnterUserController") as? EnterUserController{
            vc.delegate = self
            vc.isModalInPresentation = true
            present(vc, animated: true)
        }

    }
    
}
