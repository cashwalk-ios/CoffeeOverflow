//
//  MyQuestionsCell.swift
//  CoffeeOverflow
//
//  Created by lovecat on 2023/02/02.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout

class MyQuestionsCell: UITableViewCell {
    
    enum CellState {
        case collapsed
        case expanded
    }
    
    static let reuseIdentifier = "MyQuestionsCell"
    fileprivate let padding: CGFloat = 10
    
    fileprivate let rootFlexContainer: UIView = UIView()
    fileprivate let detailView = UIView()
    fileprivate let questionLabel = UILabel()
    fileprivate let participantsCountLabel = UILabel()
    fileprivate let descriptionLabel = UILabel()
    fileprivate let iconImageView = UIImageView()
    var deleteButton = UIButton()
    var choiceButton = UIButton()
    
    var state: CellState = .collapsed {
        didSet {
            if state == .expanded {
                isExpanded(true)
            } else {
                isExpanded(false)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        selectionStyle = .none
        separatorInset = .zero
        
        iconImageView.image = CoffeeOverflowAsset.icArrowDownGray.image
        
        rootFlexContainer.backgroundColor = .black
        contentView.addSubview(rootFlexContainer)
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor(red: 39.0 / 255.0, green: 39.0 / 255.0, blue: 41.0 / 255.0, alpha: 1.0)
        bgView.layer.cornerRadius = 10
        
        let headerView = UIView()
        let detailTopView = UIView()
        let detailBottomView = UIView()
        
        questionLabel.font = UIFont.boldSystemFont(ofSize: 12)
        questionLabel.textColor = .white
        questionLabel.lineBreakMode = .byTruncatingTail
        questionLabel.numberOfLines = 2
        
        let participantsCount = 5
        
        participantsCountLabel.font = UIFont.boldSystemFont(ofSize: 10)
        participantsCountLabel.textColor = CoffeeOverflowAsset.primaryColor.color
        participantsCountLabel.lineBreakMode = .byTruncatingTail
        participantsCountLabel.text = "0명참여중"
        
        participantsCountLabel.text = "\(participantsCount)명참여중"
        var textString = ""
        if let temp = participantsCountLabel.text {
            textString = temp
        }
        let attributedStr = NSMutableAttributedString(string: textString)
        attributedStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 8, weight: .regular), range: (textString as NSString).range(of: "명참여중"))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.white, range: (textString as NSString).range(of:"명참여중"))
        participantsCountLabel.attributedText = attributedStr
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        
        deleteButton.backgroundColor = .black
        deleteButton.setImage(CoffeeOverflowAsset.delete.image, for: .normal)
        deleteButton.layer.cornerRadius = 10
        
        choiceButton.backgroundColor = UIColor(red: 255.0 / 255.0, green: 193.0 / 255.0, blue: 46.0 / 255.0, alpha: 1.0)
        choiceButton.setImage(CoffeeOverflowAsset.choice.image, for: .normal)
        choiceButton.layer.cornerRadius = 10

        rootFlexContainer.flex.paddingLeft(20).paddingRight(20).paddingBottom(10).define { (flex) in
            flex.addItem(bgView).direction(.column).padding(12).define{ (flex) in
                flex.addItem(headerView).direction(.row).justifyContent(.spaceBetween).define{ (flex) in
                    flex.addItem(questionLabel).shrink(1)
                    flex.addItem().direction(.row).define{ (flex) in
                        flex.addItem(ParticipantsLabel)
                        flex.addItem(iconImageView).size(30)
                    }
                }
                flex.addItem().height(10)
                flex.addItem(detailView).direction(.column).define{ (flex) in
                    flex.addItem().height(10)
                    flex.addItem(detailTopView).direction(.row).wrap(.wrap).define{ (flex) in
                        for _ in 1...7 {
                            let iconImage = CoffeeOverflowAsset.icArrowDownGray.image
                            let deleteButton = UIButton()
                            deleteButton.backgroundColor = .black
                            deleteButton.setBackgroundImage(iconImage, for: .normal)
                            deleteButton.layer.cornerRadius = 10
                            flex.addItem(deleteButton).marginBottom(5).marginRight(5).size(45)
//                            flex.addItem().width(5)
                        }
                    }
                    flex.addItem().height(10)
                    flex.addItem(detailBottomView).direction(.row).justifyContent(.spaceBetween).define{ (flex) in
                        flex.addItem(deleteButton).size(50)
                        flex.addItem().width(10)
                        flex.addItem(choiceButton).height(50).grow(1)
                    }
                }
                
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(method: Method) {
        questionLabel.text = method.name
        questionLabel.flex.markDirty()
        
        descriptionLabel.text = method.description
        descriptionLabel.flex.markDirty()
        
    }
    
    func isExpanded(_ isExpanded: Bool) {
        if isExpanded {
            detailView.flex.display(.flex)
            iconImageView.image = CoffeeOverflowAsset.icArrowUpGray.image
            layout()
        } else {
            detailView.flex.display(.none)
            iconImageView.image = CoffeeOverflowAsset.icArrowDownGray.image
            layout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    fileprivate func layout() {
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the contentView's width to the specified size parameter
        rootFlexContainer.pin.width(size.width)
        
        // 2) Layout contentView flex container
        layout()
        
        // Return the flex container new size
        return rootFlexContainer.frame.size
    }
}
