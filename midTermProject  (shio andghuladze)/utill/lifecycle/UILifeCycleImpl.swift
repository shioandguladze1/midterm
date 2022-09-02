//
//  UILifeCycleImpl.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 02.09.22.
//

import Foundation

class UILifeCycleImpl: Observable, UILifeCycle{
    typealias T = UILifeCycleEvent
    
    private var observers: [Observer<T>] = []
    private (set) var lifeCycleEvent: T?
    
    func setLifecycleEvent(event: UILifeCycleEvent){
        self.lifeCycleEvent = event
        notifyObservers()
        
        if event == .DidDissapear {
            observers.removeAll()
            lifeCycleEvent = nil
        }
    }
    
    func addObserver(observer: Observer<UILifeCycleEvent>, lifeCycle: UILifeCycle) {
        observers.append(observer)
        if let lifeCycleEvent = lifeCycleEvent {
            observer.block(lifeCycleEvent)
        }
        
    }
    
    func removeObserver(observer: Observer<UILifeCycleEvent>) {
        observers.removeAll { $0.id == observer.id }
    }
    
    func onLifeCycleEvent(event: UILifeCycleEvent, block: @escaping ()-> Void){
        let observer = Observer { (e: UILifeCycleEvent) in
            if e == event{
                block()
            }
        }
        
        addObserver(observer: observer, lifeCycle: self)
    }
    
    func notifyObservers() {
        guard let lifeCycleEvent = lifeCycleEvent else {
            return
        }

        observers.forEach { $0.block(lifeCycleEvent) }
    }
    
}

enum UILifeCycleEvent {
    case WillAppear
    case DidLoad
    case WillDissapear
    case DidDissapear
}


