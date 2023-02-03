//
//  MyQuestionsView.swift
//  CoffeeOverflow
//
//  Created by lovecat on 2023/02/02.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import UIKit

class MyQuestionsView: UIView {

    fileprivate let tableView = UITableView()
    fileprivate let methodCellTemplate = MethodCell()
    
    fileprivate var methods: [Method] = []
    fileprivate var isExpanded = false
    fileprivate var isSelectIndexPath: IndexPath?
    fileprivate var indexPaths: Set<IndexPath> = []
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .black

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 10
        tableView.register(MethodCell.self, forCellReuseIdentifier: MethodCell.reuseIdentifier)
        tableView.register(MethodGroupHeader.self, forHeaderFooterViewReuseIdentifier: MethodGroupHeader.reuseIdentifier)
        tableView.backgroundColor = .black
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(methods: [Method]) {
        self.methods = methods
        tableView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.pin.all()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension MyQuestionsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MethodGroupHeader.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MethodGroupHeader.reuseIdentifier) as! MethodGroupHeader
        header.configure(title: "My Questions")
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return methods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MethodCell.reuseIdentifier, for: indexPath) as! MethodCell
        cell.configure(method: methods[indexPath.row])
        cell.state = cellIsExpanded(at: indexPath) ? .expanded : .collapsed
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // The UITableView will call the cell's sizeThatFit() method to compute the height.
        // WANRING: You must also set the UITableView.estimatedRowHeight for this to work.
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MethodCell
        
        if cell.state == .collapsed {
            cell.state = .expanded
            self.addExpandedIndexPath(indexPath)

            DispatchQueue.main.async {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        } else {
            cell.state = .collapsed
            self.removeExpandedIndexPath(indexPath)
            
            DispatchQueue.main.async {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
    }
    
    func cellIsExpanded(at indexPath: IndexPath) -> Bool {
        return indexPaths.contains(indexPath)
    }
    
    func addExpandedIndexPath(_ indexPath: IndexPath) {
        indexPaths.insert(indexPath)
    }
    
    func removeExpandedIndexPath(_ indexPath: IndexPath) {
        indexPaths.remove(indexPath)
    }
}
