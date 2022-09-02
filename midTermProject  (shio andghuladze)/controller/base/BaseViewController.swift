//
//  BaseViewController.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 02.09.22.
//

import UIKit

class BaseViewController: UIViewController {
    private let lifeCycle = UILifeCycleImpl()
    var controllerLifecycle: UILifeCycle {
        lifeCycle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifeCycle.setLifecycleEvent(event: .WillAppear)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        lifeCycle.setLifecycleEvent(event: .DidLoad)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lifeCycle.setLifecycleEvent(event: .WillDissapear)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lifeCycle.setLifecycleEvent(event: .DidDissapear)
    }

    func onLifeCycleEvent(event: UILifeCycleEvent, block: @escaping ()-> Void){
        lifeCycle.onLifeCycleEvent(event: event, block: block)
    }
}
