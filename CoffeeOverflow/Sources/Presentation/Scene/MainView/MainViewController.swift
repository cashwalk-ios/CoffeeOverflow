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

class MainViewController: UIViewController, View {

    var disposeBag = DisposeBag()
    
    fileprivate var mainView: MainView {
        return self.view as! MainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(reactor: MainReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = MainView()
        mainView.configure(profile: [])
    }
    
    func bind(reactor: MainReactor) {
        return
    }
}


// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.reuseIdentifier, for: indexPath) as! ProfileCell
        let image = UIImage(systemName: "person") ?? UIImage() // tempImage
        cell.configure(data: image)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}
