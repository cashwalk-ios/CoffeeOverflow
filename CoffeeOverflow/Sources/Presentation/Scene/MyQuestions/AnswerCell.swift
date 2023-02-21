//
//  AnswerCell.swift
//  CoffeeOverflow
//
//  Created by lovecat on 2023/02/14.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout

class AnswerCell: UICollectionViewCell {
    static let reuseIdentifier = "AnswerCell"
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 15.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: URL) {
        profileImageView.load(url: data)
    }
    
    private func setUI() {
        contentView.addSubview(profileImageView)
        profileImageView.pin.all()
    }
}
