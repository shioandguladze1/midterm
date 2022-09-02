//
//  UILifeCycle.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 02.09.22.
//

import Foundation

protocol UILifeCycle {
    
    func onLifeCycleEvent(event: UILifeCycleEvent, block: @escaping ()-> Void)
    
}
