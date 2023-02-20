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
//        profileImageView.image = data.withRoundedCorners(radius: 15.0)
        profileImageView.load(url: data)
    }
    
    private func setUI() {
        contentView.addSubview(profileImageView)
        profileImageView.pin.all()
    }
}


extension UIImage {
       // image with rounded corners
       public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
           let maxRadius = min(size.width, size.height) / 2
           let cornerRadius: CGFloat
           if let radius = radius, radius > 0 && radius <= maxRadius {
               cornerRadius = radius
           } else {
               cornerRadius = maxRadius
           }
           UIGraphicsBeginImageContextWithOptions(size, false, scale)
           let rect = CGRect(origin: .zero, size: size)
           UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
           draw(in: rect)
           let image = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return image
       }
   }
