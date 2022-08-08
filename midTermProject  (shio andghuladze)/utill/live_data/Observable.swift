//
//  Observable.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 08.08.22.
//

import Foundation

protocol Observable{
    
    associatedtype T
    
    func addObserver(observer: Observer<T>)
    
    func removeObserver(observer: Observer<T>)
    
    func notifyObservers()
    
}
