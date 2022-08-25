//
//  SplashScreenViewController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 12.08.22.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.global().async {
            sleep(3)
            self.navigate()
        }
    }
    
    private func navigate(){
        let destination = getNavDestination()
        DispatchQueue.main.async {
            self.navigateToController(identifier: destination) { (c: UIViewController) in }
        }
    }

    private func getNavDestination()-> String {
        if UserDefaults.standard.user == nil {
            return "LogInViewController"
        }else{
            return "HomeScreenController"
        }
    }

}
