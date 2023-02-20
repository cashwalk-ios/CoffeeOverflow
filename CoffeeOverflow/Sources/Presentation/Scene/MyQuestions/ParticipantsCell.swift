//
//  ParticipantsCell.swift
//  CoffeeOverflow
//
//  Created by lovecat on 2023/02/14.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout

class ParticipantsCell: UICollectionViewCell {
    static let reuseIdentifier = "ParticipantsCell"
    
    enum CellSelectedState {
        case selectd
        case unselected
    }
    
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.layer.borderColor = CoffeeOverflowAsset.primaryColor.color.cgColor
        imageView.layer.borderWidth = 0
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    
    var state: CellSelectedState = .unselected {
        didSet {
            if state == .selectd {
                isSeleted(true)
            } else {
                isSeleted(false)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: UIImage) {
        profileImageView.image = data
    }
    
    private func setUI() {
        contentView.addSubview(profileImageView)
        profileImageView.pin.all()
    }
    
    func isSeleted(_ isSeleted: Bool) {
        if isSeleted {
            print("선택")
            profileImageView.flex.display(.flex)
            profileImageView.layer.borderWidth = 2
            profileImageView.flex.layout(mode: .adjustHeight)
        } else {
            print("미선택")
            profileImageView.flex.display(.flex)
            profileImageView.layer.borderWidth = 0
            profileImageView.flex.layout(mode: .adjustHeight)
        }
    }
    
}
