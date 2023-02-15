//
//  ParticipantsView.swift
//  CoffeeOverflow
//
//  Created by lovecat on 2023/02/14.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout

class ParticipantsView: UIView {
    fileprivate let rootFlexContainer = UIView()

    private(set) var collectionView: UICollectionView
    fileprivate let cellTemplate = ParticipantsCell()

    fileprivate var profile: [User] = []
    
    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(frame: .zero)

        collectionView.register(ParticipantsCell.self, forCellWithReuseIdentifier: ParticipantsCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        rootFlexContainer.flex.define { flex in
            flex.addItem(collectionView).height(50)
        }
        addSubview(rootFlexContainer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(profile: [User]) {
        self.profile = profile
        collectionView.reloadData()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.all(pin.safeArea)
        rootFlexContainer.flex.layout()
    }
    
}


