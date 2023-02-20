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
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    override var isSelected: Bool {
            didSet{
                if isSelected {
                    profileImageView.layer.borderColor = CoffeeOverflowAsset.primaryColor.color.cgColor
                }
                else {
                    profileImageView.layer.borderColor = UIColor.clear.cgColor
                }
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    // prepare 그거 해야함..
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(user: User?) {
        guard let user = user else { return }
        profileImageView.load(url: user.profileImage!)
    }
    
    private func setUI() {
        contentView.addSubview(profileImageView)
        profileImageView.pin.all()
    }
}
