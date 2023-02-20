//
//  RequestButton.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/20.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import UIKit

class RequestButton: UIButton {
    
    private var vStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fill
        return stackview
    }()
    
    private var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = CoffeeOverflowAsset.icChecked.image
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private var requestLabel: UILabel = {
        let label = UILabel()
        label.text = "Request"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "5:00"
        label.textColor = CoffeeOverflowAsset.red.color
        label.font = .systemFont(ofSize: 10)
        label.sizeToFit()
        label.isHidden = true
        return label
        
    }()
    
    private var dimView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        view.isHidden = true
        return view
    }()
    
    override var isEnabled: Bool {
        didSet{
            if isEnabled {
                timeLabel.isHidden = true
                checkImageView.isHidden = true
                dimView.isHidden = true
            }
            else {
                timeLabel.isHidden = false
                checkImageView.isHidden = false
                dimView.isHidden = false
            }
        }
    }

    init() {
         super.init(frame: .zero)
         setUp()
     }
    
    required init?(coder: NSCoder) {
         fatalError()
        
    }
    
    func setTimeLabel(_ time: String) {
        timeLabel.text = time
    }
}

private extension RequestButton {
    func setUp() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = CoffeeOverflowAsset.gray1.color
        
        // Stack
        vStack.addArrangedSubview(requestLabel)
        vStack.addArrangedSubview(timeLabel)

        self.addSubview(checkImageView)
        self.addSubview(vStack)
        self.addSubview(dimView)
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        dimView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.leftAnchor.constraint(equalTo: leftAnchor),
            vStack.rightAnchor.constraint(equalTo: rightAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            dimView.leftAnchor.constraint(equalTo: leftAnchor),
            dimView.rightAnchor.constraint(equalTo: rightAnchor),
            dimView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dimView.topAnchor.constraint(equalTo: topAnchor),
            
            checkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15)
        ])
    }
}
