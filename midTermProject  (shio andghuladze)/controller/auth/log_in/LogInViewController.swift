//
//  LogInViewController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 12.08.22.
//

import UIKit

class LogInViewController: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeErrors()
        activityIndicator.hidesWhenStopped = true
    }
    
    private func observeErrors(){
        let observer = Observer<String>(){[weak self] message in
            self?.showAlertWithOkButton(title: "Error", body: message)
            self?.activityIndicator.stopAnimating()
        }
        viewModel.errorLiveData.addObserver(observer: observer)
    }
    
    @IBAction func onLogIn(_ sender: Any) {
        activityIndicator.startAnimating()
        viewModel.logIn(email: emailTF.getText(), password: passwordTF.getText()) { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.navigateToController(identifier: "HomeScreenController") { (c: UIViewController) in}
        }
    }

    @IBAction func onRegister(_ sender: Any) {
        navigateToController(identifier: "RegistrationViewController") { (c: RegistrationViewController) in}
    }
}
