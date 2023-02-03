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
    fileprivate let nameLabel = UILabel()
    fileprivate let ParticipantsLabel = UILabel()
    fileprivate let descriptionLabel = UILabel()
    fileprivate let iconImageView = UIImageView()
    
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
        
        iconImageView.image = UIImage(named: "icArrowDownGray")
        
        rootFlexContainer.backgroundColor = .black
        contentView.addSubview(rootFlexContainer)
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor(red: 39.0 / 255.0, green: 39.0 / 255.0, blue: 41.0 / 255.0, alpha: 1.0)
        bgView.layer.cornerRadius = 10
        
        let headerView = UIView()
        let detailTopView = UIView()
        let detailBottomView = UIView()
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.textColor = .white
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.numberOfLines = 2
        
        ParticipantsLabel.font = UIFont.boldSystemFont(ofSize: 12)
        ParticipantsLabel.textColor = .white
        ParticipantsLabel.lineBreakMode = .byTruncatingTail
        ParticipantsLabel.text = "7명참여중"
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        
        let deleteButton = UIButton(type: .system)
        deleteButton.backgroundColor = .black
        deleteButton.setTitle("삭제", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        deleteButton.layer.cornerRadius = 10
        
        let choiceButton = UIButton(type: .system)
        choiceButton.backgroundColor = UIColor(red: 255.0 / 255.0, green: 193.0 / 255.0, blue: 46.0 / 255.0, alpha: 1.0)
        choiceButton.setTitle("채택", for: .normal)
        choiceButton.setTitleColor(.white, for: .normal)
        choiceButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        choiceButton.layer.cornerRadius = 10

        rootFlexContainer.flex.paddingBottom(20).define { (flex) in
            flex.addItem(bgView).direction(.column).padding(12).define{ (flex) in
                flex.addItem(headerView).direction(.row).justifyContent(.spaceBetween).define{ (flex) in
                    flex.addItem(nameLabel).shrink(1)
                    flex.addItem().direction(.row).define{ (flex) in
                        flex.addItem(ParticipantsLabel)//.marginLeft(padding)//.grow(1)
                        flex.addItem(iconImageView).size(30)//.marginRight(padding)
                    }
                }
                flex.addItem(detailView).direction(.column).define{ (flex) in
                    flex.addItem(detailTopView).direction(.row).wrap(.wrap).define{ (flex) in
                        for _ in 1...7 {
                            let iconImageView = UIImageView(image: UIImage(named: "icArrowDownGray"))
                            flex.addItem(iconImageView).size(50)
                        }
                    }
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
        nameLabel.text = method.name
        nameLabel.flex.markDirty()
        
        descriptionLabel.text = method.description
        descriptionLabel.flex.markDirty()
        
    }
    
    func isExpanded(_ isExpanded: Bool) {
        if isExpanded {
            detailView.flex.display(.flex)
            iconImageView.image = UIImage(named: "icArrowUpGray")
            layout()
        } else {
            detailView.flex.display(.none)
            iconImageView.image = UIImage(named: "icArrowDownGray")
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
