//
//  ProfileCell.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/06.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

class ProfileCell: UICollectionViewCell {
    static let reuseIdentifier = "ProfileCell"
    
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
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
}
