//
//  GeneralExtensions.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import Foundation
import UIKit

extension UITextField{
    
    func getText()-> String{
        return text ?? ""
    }
    
}

extension UIViewController{
    
    func showAlertWithOkButton(title: String, body: String){
        let dialogMessage = UIAlertController(title: title, message: body, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default){_ in
            dialogMessage.dismiss(animated: true)
        }
        
        dialogMessage.addAction(ok)

        self.present(dialogMessage, animated: true, completion: nil)
    }
    
}
