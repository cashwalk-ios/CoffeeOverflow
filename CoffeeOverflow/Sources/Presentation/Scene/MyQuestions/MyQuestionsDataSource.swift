//
//  MyQuestionsDataSource.swift
//  CoffeeOverflow
//
//  Created by lovecat on 2023/02/02.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MyQuestionsDataSource: NSObject, UITableViewDataSource {
    
    fileprivate var indexPaths: Set<IndexPath> = []
    var methods: [Method] = []
    private let disposeBag = DisposeBag()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return methods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyQuestionsCell.reuseIdentifier, for: indexPath) as! MyQuestionsCell
        cell.configure(method: methods[indexPath.row])
        cell.state = cellIsExpanded(at: indexPath) ? .expanded : .collapsed
        
        cell.deleteButton.rx.tap
            .bind { [weak self] (_) in
//                guard let self = self else {return}
                print("삭제버튼 누름")
            }.disposed(by: disposeBag)
        
        cell.choiceButton.rx.tap
            .bind { (_) in
                print("채택버튼 누름")
            }.disposed(by: disposeBag)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MyQuestionsDataSource {
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
