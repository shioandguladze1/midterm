//
//  LiveData.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 08.08.22.
//

import Foundation

class LiveData<T>: Observable{
    private var observers: [Observer<T>] = []
    private (set) var data: T?
    
    func setData(data: T){
        self.data = data
        notifyObservers()
    }
    
    func addObserver(observer: Observer<T>) {
        observers.append(observer)
        if data != nil { observer.block(data!) }
    }
    
    func removeObserver(observer: Observer<T>) {
        if let index = observers.firstIndex(of: observer){
            observers.remove(at: index)
        }
    }
    
    func notifyObservers() {
        observers.forEach { observer in
            if data != nil { observer.block(data!) }
        }
    }
    
}
