//
//  RegistrationViewController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 12.08.22.
//

import UIKit

class RegistrationViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    private let imagePicker = UIImagePickerController()
    private let viewModel = RegistrationViewModel()
    private var imageUrl: String?
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var repeatPasswordTF: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleImageView()
        configureTapOnImgeView()
        observeToErrors()
        activityIndicator.hidesWhenStopped = true
    }
    
    private func observeToErrors(){
        let observer = Observer<String>(){ [weak self] error in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.showAlertWithOkButton(title: "Error", body: error)
            }
        }
        viewModel.errorLiveData.addObserver(observer: observer)
    }
    
    private func styleImageView(){
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = CGColor(red: 0, green: 0, blue: 255, alpha: 1)
        profileImageView.layer.cornerRadius = view.frame.width * 0.2
    }
    
    private func configureTapOnImgeView(){
        let gr = UITapGestureRecognizer(target: self, action: #selector(self.onImageViewTap(_:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(gr)
        imagePicker.delegate = self
    }
    
    @objc func onImageViewTap(_ sender: UITapGestureRecognizer?){
        present(imagePicker, animated: true)
    }
    
    @IBAction func onRegister(_ sender: Any) {
        activityIndicator.startAnimating()
        
        guard let imageUrl = imageUrl else{
            showAlertWithOkButton(title: "Error", body: "Could not open image")
            activityIndicator.stopAnimating()
            return
        }
        
        viewModel.registerUser(userName: userNameTF.getText(), email: emailTF.getText(), password: passwordTF.getText(), imageLocalUrl: imageUrl, repeatedPassword: repeatPasswordTF.getText()) { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.navigateToController(identifier: "HomeScreenController") { (c: UIViewController) in }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
}

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[.imageURL] as? NSURL{
            imageUrl = url.absoluteString
        }
        
        if let image = info[.originalImage] as? UIImage{
            profileImageView.image = image
            dismiss(animated: true)
        }
    }
    
}
