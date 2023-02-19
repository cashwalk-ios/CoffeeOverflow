//
//  MyQuestionsView.swift
//  CoffeeOverflow
//
//  Created by lovecat on 2023/02/02.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import UIKit
import PinLayout
import RxSwift
import RxCocoa

protocol myQuestionsViewDelegate: NSObjectProtocol {
    func deleteQuestionButtonClicked(_ view: MyQuestionsView, question: Question)
//    func deleteQuestionButtonClicked(_ view: MyQuestionsView)
}

class MyQuestionsView: UIView {
    fileprivate let tableView = UITableView(frame: .zero, style: .grouped)
    fileprivate let MyQuestionsCellTemplate = MyQuestionsCell()
    
    fileprivate var isExpanded = false
    fileprivate var isSelectIndexPath: IndexPath?
    
    fileprivate var indexPaths: Set<IndexPath> = []
    fileprivate var question: [Question] = []
//    fileprivate var methods: [Method] = []
    fileprivate var selectionAnswerUseCase: SelectionAnswerUseCase?
    fileprivate var deleteQuestionUseCase: DeleteQuestionUseCase?
    fileprivate let disposeBag = DisposeBag()
    
    weak var delegate: myQuestionsViewDelegate?
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .black

        tableView.dataSource = self
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
    
    func configure(question: [Question], selectionAnswerUseCase: SelectionAnswerUseCase, deleteQuestionUseCase: DeleteQuestionUseCase) {
        print("질문??: \(question)")
        self.question = question
        tableView.reloadData()
    }
    
//    func configure(methods: [Method]) {
//        self.methods = methods
//        tableView.reloadData()
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.pin.all(safeAreaInsets)
    }
}

// MARK: UITableViewDelegate
extension MyQuestionsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MyQuestionsCell
        
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MyQuestionsHeader.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyQuestionsHeader.reuseIdentifier) as! MyQuestionsHeader
        header.configure(title: "My Questions")
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return question.count
//        return methods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyQuestionsCell.reuseIdentifier, for: indexPath) as! MyQuestionsCell
        let question = self.question[indexPath.row]
        cell.configure(question: question)
//        cell.configure(methods: methods[indexPath.row])
        
        cell.state = cellIsExpanded(at: indexPath) ? .expanded : .collapsed
        cell.deleteQuestionButton.rx.tap
            .bind { [weak self] (_) in
                guard let self = self else {return}
                print("삭제버튼")
//                self.delegate?.deleteQuestionButtonClicked(self)
                self.delegate?.deleteQuestionButtonClicked(self, question: question)
            }.disposed(by: disposeBag)
        
        cell.selectionAnswerButton.rx.tap
            .bind { [weak self] (_) in
                guard let self = self else {return}
                print("채택버튼 누름 \(cell.selectedIndexPathRow)")
                guard let row = cell.selectedIndexPathRow, let answer = question.answerer?[row] else {return}
                self.selectionAnswerUseCase?.excute(question: question, answer: answer)
            }.disposed(by: disposeBag)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension MyQuestionsView {
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
