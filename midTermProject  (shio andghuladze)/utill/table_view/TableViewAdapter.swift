//
//  TableViewAdapter.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 29.07.22.
//

import Foundation
import UIKit

class TableViewAdapter<T, C: UITableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate{
    var data: [T] = []
    let tableView: UITableView
    let cellIdentifier: String
    let rowHeight: CGFloat
    
    init(tableView: UITableView, cellIdentifier: String, rowHeight: CGFloat){
        self.tableView = tableView
        self.cellIdentifier = cellIdentifier
        self.rowHeight = rowHeight
        super.init()
        configureTableView()
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func configureCell(cell: C, data: T){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? C{
            configureCell(cell: cell, data: data[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func setData(data: [T]){
        self.data = data
        tableView.reloadData()
    }
    
}
