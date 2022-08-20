//
//  GeneralSearchBarDelegate.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 20.08.22.
//

import Foundation
import UIKit

class GeneralSearchBarDelegate<T>: NSObject, UISearchBarDelegate{
    private var initialList = [T]()
    private var searchList = [T]()
    private let filterClosure: (T, String)-> Bool
    var onValueChanged: (([T])-> Void)? = nil
    
    init(filterClosure: @escaping (T, String)-> Bool){
        self.filterClosure = filterClosure
    }
    
    func updateInitialList(list: [T]){
        initialList = list
        searchList = list
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchList = initialList
        }else {
            searchList = initialList.filter { filterClosure($0, searchText) }
        }
        
        onValueChanged?(searchList)
    }
    
}
