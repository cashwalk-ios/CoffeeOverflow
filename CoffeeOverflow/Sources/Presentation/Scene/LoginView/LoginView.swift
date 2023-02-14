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
import GoogleSignIn

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
        imageView.image = CoffeeOverflowAsset.nudgeCup.image
        return imageView
    }()

    private(set) var loginButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.style = .wide
        button.colorScheme = .light
        button.layer.cornerRadius = 10
        return button
    }()
    
    private var bgImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = CoffeeOverflowAsset.bgGradient.image
        return imageView
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
        addSubview(bgImageView)
        addSubview(rootFlexContainer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        bgImageView.pin.top().left().right().pinEdges()
        bgImageView.pin.width(100%).aspectRatio()
        rootFlexContainer.pin.all(pin.safeArea)
        rootFlexContainer.flex.layout()
    }
}
