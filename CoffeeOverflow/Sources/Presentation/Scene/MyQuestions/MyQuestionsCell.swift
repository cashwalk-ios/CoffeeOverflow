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
    fileprivate var participantsView = ParticipantsView()
    
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
        
        participantsView.collectionView.delegate = self
        participantsView.collectionView.dataSource = self
        
        participantsView.configure(profile: [
//            Profile(name: "Mock", image: URL(string: "https://i.pinimg.com/736x/76/cc/b4/76ccb45bc61b098c7b9b75de62fcf533--house-design-campo-grande.jpg")!),
//            Profile(name: "Mock", image: URL(string: "https://i.pinimg.com/736x/76/cc/b4/76ccb45bc61b098c7b9b75de62fcf533--house-design-campo-grande.jpg")!),
//            Profile(name: "Mock", image: URL(string: "https://i.pinimg.com/736x/76/cc/b4/76ccb45bc61b098c7b9b75de62fcf533--house-design-campo-grande.jpg")!),
//            Profile(name: "Mock", image: URL(string: "https://i.pinimg.com/736x/76/cc/b4/76ccb45bc61b098c7b9b75de62fcf533--house-design-campo-grande.jpg")!),
//            Profile(name: "Mock", image: URL(string: "https://i.pinimg.com/736x/76/cc/b4/76ccb45bc61b098c7b9b75de62fcf533--house-design-campo-grande.jpg")!),
//            Profile(name: "Mock", image: URL(string: "https://i.pinimg.com/736x/76/cc/b4/76ccb45bc61b098c7b9b75de62fcf533--house-design-campo-grande.jpg")!),
//            Profile(name: "Mock", image: URL(string: "https://i.pinimg.com/736x/76/cc/b4/76ccb45bc61b098c7b9b75de62fcf533--house-design-campo-grande.jpg")!)
        ])
        
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
        
        let participantsCount = 7
        
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

        rootFlexContainer.flex.paddingLeft(20).paddingRight(20).paddingBottom(22).define { (flex) in
            flex.addItem(bgView).direction(.column).justifyContent(.center).padding(12).define{ (flex) in
                flex.addItem(headerView).direction(.row).justifyContent(.spaceBetween).define{ (flex) in
                    flex.addItem(questionLabel).shrink(1)
                    flex.addItem().direction(.row).define{ (flex) in
                        flex.addItem(participantsCountLabel)
                        flex.addItem(iconImageView).size(30)
                    }
                }
                flex.addItem(detailView).direction(.column).define{ (flex) in
                    flex.addItem().height(10)
//                    flex.addItem(detailTopView).direction(.row).wrap(.wrap).define{ (flex) in
//                        for buttonTag in 1...participantsCount {
//                            let iconImage = CoffeeOverflowAsset.icArrowDownGray.image
//                            let participantsButton = UIButton()
//                            participantsButton.backgroundColor = .black
//                            participantsButton.setBackgroundImage(iconImage, for: .normal)
//                            participantsButton.layer.cornerRadius = 10
//                            participantsButton.tag = buttonTag
//                            flex.addItem(participantsButton).marginBottom(5).marginRight(5).size(40)
//                        }
                    flex.addItem(participantsView).width(100%).height(50)
//                    }
                    flex.addItem().height(10)
                    flex.addItem(detailBottomView).direction(.row).justifyContent(.spaceBetween).define{ (flex) in
                        flex.addItem(deleteButton).size(40)
                        flex.addItem().width(10)
                        flex.addItem(choiceButton).height(40).grow(1)
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

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension MyQuestionsCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.reuseIdentifier, for: indexPath) as! ProfileCell
        let image = UIImage(systemName: "person") ?? UIImage() // tempImage
        cell.configure(data: image)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
