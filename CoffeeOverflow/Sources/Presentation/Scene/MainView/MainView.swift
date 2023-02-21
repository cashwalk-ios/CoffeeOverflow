//
//  MainView.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/06.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

class MainView: UIView {
    
    fileprivate let rootFlexContainer = UIView()
    
    private(set) var collectionView: UICollectionView
    fileprivate let cellTemplate = ProfileCell()
    
    fileprivate var profile: [User] = []
    
    private(set) var cupsLabel: UILabel = {
        let label = UILabel()
        label.text = "6"
        label.font = .boldSystemFont(ofSize: 60)
        label.textColor = .white
        return label
    }()
    
    private(set) var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Cups"
        label.font = .systemFont(ofSize: 40)
        label.textColor = .white
        return label
    }()

    private(set) var requestButton: RequestButton = {
        let button = RequestButton()
        button.isHidden = true
        return button
    }()
    
    private(set) var confirmButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Confirm", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.backgroundColor = UIColor(red: 255/255, green: 193/255, blue: 46/255, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
    private(set) var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "사용하실 수 있는 커피가 없어요.\n어서 좋은 답변자가 되어 커피를 얻어보세요!"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = CoffeeOverflowAsset.gray3.color
        label.sizeToFit()
        return label
    }()
    
    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(frame: .zero)

        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        
        rootFlexContainer.flex.define { flex in
            flex.addItem().marginHorizontal(30).marginTop(50).define { flex in
                flex.addItem().direction(.row).define { flex in
                    flex.addItem(cupsLabel).marginRight(5)
                    flex.addItem(textLabel)
                    }
                flex.addItem(collectionView).height(80%).marginTop(10)
                }
                
            flex.addItem().direction(.columnReverse).marginHorizontal(22).define { flex in
                flex.addItem().direction(.row).justifyContent(.spaceBetween).height(50).define { flex in
                    flex.addItem(requestButton).width(48%)
                    flex.addItem(confirmButton).width(48%)
                }
            }
        }
        addSubview(rootFlexContainer)
        addSubview(emptyLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(profile: [User]) {
        self.profile = profile
        collectionView.reloadData()
    }
    
    func activateButtons(){
        self.confirmButton.isHidden = false
        self.requestButton.isHidden = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.all(pin.safeArea)
        rootFlexContainer.flex.layout()
        emptyLabel.pin.vCenter().hCenter()
        emptyLabel.flex.layout()
    }
}

