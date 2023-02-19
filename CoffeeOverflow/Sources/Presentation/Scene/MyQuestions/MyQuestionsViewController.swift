//
//  MyQuestionsViewController.swift
//  CoffeeOverflow
//
//  Created by lovecat on 2023/01/31.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import UIKit
import ReactorKit
import FlexLayout
import PinLayout
import RxSwift
import RxCocoa

struct Method {
    let name: String
    let description: String
}

class MyQuestionsViewController: UIViewController, View, myQuestionsViewDelegate {
    func deleteQuestionButtonClicked(_ view: MyQuestionsView, question: Question) {
        let alertController = UIAlertController(title: "잠시만요!", message: "정말 아무도 채택하지 않고 삭제하실건가요?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("삭제취소 누름")
        }
        let okAction = UIAlertAction(title: "삭제", style: .default) { _ in
            print("삭제버튼 누름")
            self.deleteQuestionUseCase?.excute(question: question)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    private var fetchMyQuestionsUseCase: FetchMyQuestionsUseCase?
    private var selectionAnswerUseCase: SelectionAnswerUseCase?
    private var deleteQuestionUseCase: DeleteQuestionUseCase?
    
    fileprivate var myQuestionsView: MyQuestionsView {
        return self.view as! MyQuestionsView
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = MyQuestionsView()
        myQuestionsView.delegate = self
    }
    
    init(reactor: MyQuestionsViewReactor, fetchMyQuestionsUseCase: FetchMyQuestionsUseCase, selectionAnswerUseCase: SelectionAnswerUseCase, deleteQuestionUseCase: DeleteQuestionUseCase) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
        self.fetchMyQuestionsUseCase = fetchMyQuestionsUseCase
        self.selectionAnswerUseCase = selectionAnswerUseCase
        self.deleteQuestionUseCase = deleteQuestionUseCase
        
        guard let selectionAnswerUseCase = self.selectionAnswerUseCase, let deleteQuestionUseCase = self.deleteQuestionUseCase else {return}
        
        self.fetchMyQuestionsUseCase?.excute()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { questions in
                print("questions: ", questions)
                self.myQuestionsView.configure(question: questions, selectionAnswerUseCase: selectionAnswerUseCase, deleteQuestionUseCase: deleteQuestionUseCase)
            }, onFailure: { error in
                print("Error: ", error)
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: MyQuestionsViewReactor) {
        return
    }
}
