//
//  LoginView.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/02.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

class LoginView: UIView {

    fileprivate let rootFlexContainer = UIView()

    private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Coffee Overflow"
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NudgeCup") ?? UIImage()
        return imageView
    }()

    private(set) var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(" Sign Up with Google", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        button.setImage(UIImage(named: "GoogleLogo"), for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return button
    }()

    init() {
        super.init(frame: .zero)
        rootFlexContainer.flex.justifyContent(.spaceAround).direction(.column).marginHorizontal(30).define { (flex) in
            flex.addItem(titleLabel).width(50%)
            flex.addItem().alignItems(.center).direction(.column).define { flex in
                flex.addItem(imageView).height(250).width(250).marginTop(10)
            }
            flex.addItem(UIView()).height(100)
            flex.addItem(loginButton).height(54)
        }
        addSubview(rootFlexContainer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.all(pin.safeArea)
        rootFlexContainer.flex.layout()
    }
}