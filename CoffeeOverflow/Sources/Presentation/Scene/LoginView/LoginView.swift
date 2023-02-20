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
        label.text = "Coffee\nOverflow"
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

    private(set) var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setImage(
            CoffeeOverflowAsset.continueWithGoogle.image.withRenderingMode(.alwaysOriginal),
            for: .normal
        )
        return button
    }()
    
    private var bgImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = CoffeeOverflowAsset.bgGradient.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    init() {
        super.init(frame: .zero)
        self.backgroundColor = CoffeeOverflowAsset.backgroundColor.color
        self.rootFlexContainer.flex
            .alignItems(.center)
            .justifyContent(.start)
            .direction(.column)
            .marginHorizontal(30)
            .define { flex in
                flex.addItem(self.titleLabel).width(100%).marginTop(50)
                flex.addItem(self.imageView).width(100%).aspectRatio(1).marginTop(10)
            }
        self.addSubview(bgImageView)
        self.addSubview(rootFlexContainer)
        self.addSubview(loginButton)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.bgImageView.pin.top().left().right().pinEdges()
        self.bgImageView.pin.width(100%).aspectRatio()
        self.rootFlexContainer.pin.all(pin.safeArea)
        self.rootFlexContainer.flex.layout()
        self.loginButton.pin.height(54)
        self.loginButton.pin.bottom(pin.safeArea).marginBottom(30)
        self.loginButton.pin.left().right().margin(30)
    }
}
