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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleImageView()
        configureTapOnImgeView()
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
    
}

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            profileImageView.image = image
            dismiss(animated: true)
        }
    }
    
}
