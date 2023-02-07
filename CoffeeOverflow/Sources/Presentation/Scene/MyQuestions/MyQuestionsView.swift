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

    fileprivate let tableView = UITableView(frame: .zero, style: .grouped)
    fileprivate let MyQuestionsCellTemplate = MyQuestionsCell()
    
    fileprivate var isExpanded = false
    fileprivate var isSelectIndexPath: IndexPath?
    fileprivate var dataSource = MyQuestionsDataSource()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .black

        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.estimatedRowHeight = 10
        tableView.register(MyQuestionsCell.self, forCellReuseIdentifier: MyQuestionsCell.reuseIdentifier)
        tableView.register(MyQuestionsHeader.self, forHeaderFooterViewReuseIdentifier: MyQuestionsHeader.reuseIdentifier)
        tableView.backgroundColor = .black
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(methods: [Method]) {
        dataSource.methods = methods
        tableView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.pin.all()
    }
}

// MARK: UITableViewDelegate
extension MyQuestionsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MyQuestionsCell
        
        if cell.state == .collapsed {
            cell.state = .expanded
            dataSource.addExpandedIndexPath(indexPath)

            DispatchQueue.main.async {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        } else {
            cell.state = .collapsed
            dataSource.removeExpandedIndexPath(indexPath)
            
            DispatchQueue.main.async {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MyQuestionsHeader.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyQuestionsHeader.reuseIdentifier) as! MyQuestionsHeader
        header.configure(title: "My Questions")
        return header
    }
}
