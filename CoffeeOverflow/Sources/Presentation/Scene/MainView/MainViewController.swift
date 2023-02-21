//
//  MainViewController.swift.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/05.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import UIKit
import ReactorKit
import FlexLayout
import PinLayout
import RxCocoa
import RxSwift

class MainViewController: UIViewController, View {

    var disposeBag = DisposeBag()
    private var timer: Timer?
    private var questionVC: MyQuestionsViewController
    
    fileprivate var mainView: MainView {
        return self.view as! MainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    init(reactor: MainReactor, questionVC: MyQuestionsViewController) {
        self.questionVC = questionVC
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = MainView()
        view.backgroundColor = CoffeeOverflowAsset.backgroundColor.color
        reactor?.action.onNext(.fetchMyQuestion)
        reactor?.action.onNext(.fetch)
    }
    
    func bind(reactor: MainReactor) {
        
        // MARK: Action
        mainView.collectionView.rx.itemSelected
            .withUnretained(self)
            .subscribe(onNext: { vc, indexPath in
                reactor.action.onNext(.select(index: indexPath.row))
                let cell = vc.mainView.collectionView.cellForItem(at: indexPath)
                cell?.isSelected.toggle()
            }).disposed(by: disposeBag)
        
        mainView.collectionView.rx.itemSelected
            .take(1)
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { vc, indexPath in
                vc.mainView.activateButtons()
            }).disposed(by: disposeBag)
        
        mainView.requestButton.rx.tapGesture()
            .when(.recognized )
            .map{ _ in Reactor.Action.requestCoffee }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        mainView.confirmButton.rx.tap
            .map{ Reactor.Action.confirmRecived }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // MARK: State
        reactor.pulse(\.$coffeePurchasers)
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: ProfileCell.reuseIdentifier, cellType: ProfileCell.self)) { _, item, cell in
                cell.configure(user: item.user)
            }.disposed(by: disposeBag)
        
        reactor.pulse(\.$coffeePurchasers)
            .map { "\($0.count)" }
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { vc, count in
                vc.mainView.cupsLabel.text = count
            }.disposed(by: disposeBag)
        
        reactor.pulse(\.$coffeePurchasers)
            .map { $0.count != 0 }
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe { vc, isExistCoffee in
                vc.mainView.emptyLabel.isHidden = isExistCoffee
            }.disposed(by: disposeBag)
        
        reactor.state.map(\.isRequesting)
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe { vc, isRequesting in
                if isRequesting {
                    reactor.action.onNext(.startTimer)
                } else {
                    vc.timer?.invalidate()
                }
                vc.mainView.requestButton.isEnabled = !isRequesting
            }.disposed(by: disposeBag)
        
        reactor.state.map(\.isShowQuestionView)
            .filter { $0 }
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe { vc, _ in
                self.questionVC.isModalInPresentation = true
                self.present(self.questionVC, animated: true)
            }.disposed(by: disposeBag)
        
        reactor.state.map(\.remainTime)
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { vc, timeStr in
                vc.mainView.requestButton.setTimeLabel(timeStr)
            }.disposed(by: disposeBag)
    }
}


// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}

