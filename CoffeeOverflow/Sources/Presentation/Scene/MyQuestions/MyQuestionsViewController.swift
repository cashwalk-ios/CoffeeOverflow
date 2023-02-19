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
//    func deleteQuestionButtonClicked(_ view: MyQuestionsView) {
//        let alertController = UIAlertController(title: "잠시만요!", message: "정말 아무도 채택하지 않고 삭제하실건가요?", preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
//            print("삭제취소 누름")
//        }
//        let okAction = UIAlertAction(title: "삭제", style: .default) { _ in
//            print("삭제버튼 누름")
//        }
//        alertController.addAction(cancelAction)
//        alertController.addAction(okAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
    
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
    var questions = PublishRelay<[Question]>()
    
    fileprivate var myQuestionsView: MyQuestionsView {
        return self.view as! MyQuestionsView
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.fetchMyQuestionsUseCase?.excute()
//            .asObservable()
//            .bind(to: questions)
//            .disposed(by: disposeBag)
//
//        print(questions)
//
//        guard let selectionAnswerUseCase = self.selectionAnswerUseCase, let deleteQuestionUseCase = self.deleteQuestionUseCase else {return}
//
//        questions
//            .subscribe(onNext: { [weak self] question in
//                print("22222: \(question)")
////                self?.myQuestionsView.configure(question: question, selectionAnswerUseCase: selectionAnswerUseCase, deleteQuestionUseCase: deleteQuestionUseCase)
//            })
//            .disposed(by: disposeBag)
        
    }
    
    override func loadView() {
        view = MyQuestionsView()
        myQuestionsView.delegate = self
        
//        self.fetchMyQuestionsUseCase?.excute()
//            .asObservable()
//            .bind(to: questions)
//            .disposed(by: disposeBag)
//
//        print(questions)
//
//        guard let selectionAnswerUseCase = self.selectionAnswerUseCase, let deleteQuestionUseCase = self.deleteQuestionUseCase else {return}
//
//        questions
//            .subscribe(onNext: { [weak self] question in
//                self?.myQuestionsView.configure(question: question, selectionAnswerUseCase: selectionAnswerUseCase, deleteQuestionUseCase: deleteQuestionUseCase)
//            })
//            .disposed(by: disposeBag)
//
        
//        myQuestionsView.configure(methods: [
//            Method(name: "질문1", description: "The direction property establishes the main-axis, thus defining the direction flex items are placed in the flex container container container."),
//            Method(name: "질문1", description: "The direction property establishes the main-axis, thus defining the direction flex items are placed in the flex container container container."),
//            Method(name: "질문1", description: "The direction property establishes the main-axis, thus defining the direction flex items are placed in the flex container container container."),
//            Method(name: "질문1", description: "The direction property establishes the main-axis, thus defining the direction flex items are placed in the flex container container container."),
//            Method(name: "질문1", description: "The direction property establishes the main-axis, thus defining the direction flex items are placed in the flex container container container."),
//
//            Method(name: "질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2질문2", description: "The `wrap` property controls whether the flex container is single-lined or multi-lined, and the direction of the cross-axis, which determines the direction in which the new lines are stacked in.\n\nBy default, the flex container fits all flex items into one line. Using this property we can change that. We can tell the container to lay out its items in single or multiple lines, and the direction the new lines are stacked in."),
//
//            Method(name: "질문3", description: "The `justifyContent` property defines the alignment along the main-axis of the current line of the flex container. It helps distribute extra free space leftover when either all the flex items on a line have reached their maximum size. "),
//
//            Method(name: "질문4", description: "The `alignItems` property defines how flex items are laid out along the cross axis on the current line. Similar to `justifyContent` but for the cross-axis (perpendicular to the main-axis)."),
//
//            Method(name: "질문5", description: "The `alignSelf` property controls how a child aligns in the cross direction, overriding the `alignItems` of the parent. For example, if children are flowing vertically, `alignSelf` will control how the flex item will align horizontally.\n\n The \"auto\" value means use the flex container `alignItems` property. See `alignItems` for documentation of the other values."),
//
//            Method(name: "질문6", description: "The align-content property aligns a flex container’s lines within the flex container when there is extra space in the cross-axis, similar to how justifyContent aligns individual items within the main-axis.\n\nNote, alignContent has no effect when the flexbox has only a single line."),
//
//            Method(name: "질문7", description: "The layoutDirection property controls the flex container layout direction.\n\nValues:\n-`.inherit`\n  Direction defaults to Inherit on all nodes except the root which defaults to LTR. It is up to you to detect the user’s preferred direction (most platforms have a standard way of doing this) and setting this direction on the root of your layout tree.\n-.ltr: Layout views from left to right. (Default)\n-.rtl: Layout views from right to left.")
//
//        ])
    }
    
    init(reactor: MyQuestionsViewReactor, fetchMyQuestionsUseCase: FetchMyQuestionsUseCase, selectionAnswerUseCase: SelectionAnswerUseCase, deleteQuestionUseCase: DeleteQuestionUseCase) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
        self.fetchMyQuestionsUseCase = fetchMyQuestionsUseCase
        self.selectionAnswerUseCase = selectionAnswerUseCase
        self.deleteQuestionUseCase = deleteQuestionUseCase
        
        self.fetchMyQuestionsUseCase?.excute()
            .asObservable()
            .bind(to: questions)
            .disposed(by: disposeBag)
        
        print(questions)
        
        guard let selectionAnswerUseCase = self.selectionAnswerUseCase, let deleteQuestionUseCase = self.deleteQuestionUseCase else {return}
        
        self.fetchMyQuestionsUseCase?.excute()
            .subscribe(onSuccess: { questions in
                print("questions: ", questions.count)
            }, onFailure: { error in
                print("Error: ", error)
            })
            .disposed(by: disposeBag)
        
//        questions
//            .subscribe(onNext: { [weak self] question in
//                print("22222: \(question)")
////                self?.myQuestionsView.configure(question: question, selectionAnswerUseCase: selectionAnswerUseCase, deleteQuestionUseCase: deleteQuestionUseCase)
//            })
//            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: MyQuestionsViewReactor) {
        return
    }
}
