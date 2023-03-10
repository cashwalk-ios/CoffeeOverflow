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
import RxSwift

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
    fileprivate let answerCountLabel = UILabel()
    fileprivate let iconImageView = UIImageView()
    var deleteQuestionButton = UIButton()
    var selectionAnswerButton = UIButton()
    fileprivate var answerView = AnswerView()
    fileprivate var question: Question?
    var disposeBagCell = DisposeBag()
    
    fileprivate var indexPaths: Set<IndexPath> = []
    
    var selectedIndexPathRow: Int?
    
    var state: CellState = .collapsed {
        didSet {
            if state == .expanded {
                isExpanded(true)
            } else {
                isExpanded(false)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBagCell = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = CoffeeOverflowAsset.backgroundColor.color
        selectionStyle = .none
        separatorInset = .zero
        
        answerView.collectionView.delegate = self
        answerView.collectionView.dataSource = self
        
        iconImageView.image = UIImage(systemName: "chevron.down")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage()
        
        rootFlexContainer.backgroundColor = CoffeeOverflowAsset.backgroundColor.color
        contentView.addSubview(rootFlexContainer)
        
        let bgView = UIView()
        bgView.backgroundColor = CoffeeOverflowAsset.gray1.color
        bgView.layer.cornerRadius = 10
        
        let headerView = UIView()
        let detailBottomView = UIView()
        
        questionLabel.font = UIFont.boldSystemFont(ofSize: 12)
        questionLabel.textColor = .white
        questionLabel.lineBreakMode = .byTruncatingTail
        questionLabel.numberOfLines = 2
        
        answerCountLabel.font = UIFont.boldSystemFont(ofSize: 10)
        answerCountLabel.textColor = CoffeeOverflowAsset.primaryColor.color
        answerCountLabel.lineBreakMode = .byTruncatingTail
        answerCountLabel.text = "0명참여중"
        
        var textString = ""
        if let temp = answerCountLabel.text {
            textString = temp
        }
        let attributedStr = NSMutableAttributedString(string: textString)
        attributedStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 8, weight: .regular), range: (textString as NSString).range(of: "명참여중"))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.white, range: (textString as NSString).range(of:"명참여중"))
        answerCountLabel.attributedText = attributedStr
        
        deleteQuestionButton.backgroundColor = CoffeeOverflowAsset.gray2.color
        let deleteImage = UIImage(systemName: "trash.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal) ?? UIImage()
        deleteQuestionButton.setImage(deleteImage, for: .normal)
        deleteQuestionButton.layer.cornerRadius = 10
        deleteQuestionButton.layer.borderColor = UIColor.white.cgColor
        deleteQuestionButton.layer.borderWidth = 0.5
        
        selectionAnswerButton.backgroundColor = CoffeeOverflowAsset.primaryColor.color
        let cohiceImage = UIImage(systemName: "checkmark")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage()
        selectionAnswerButton.setImage(cohiceImage, for: .normal)
        selectionAnswerButton.layer.cornerRadius = 10

        rootFlexContainer.flex.paddingLeft(20).paddingRight(20).paddingBottom(22).define { (flex) in
            flex.addItem(bgView).direction(.column).justifyContent(.center).padding(12).define{ (flex) in
                flex.addItem(headerView).direction(.row).justifyContent(.spaceBetween).define{ (flex) in
                    flex.addItem(questionLabel).shrink(1)
                    flex.addItem().direction(.row).alignItems(.center).define{ (flex) in
                        flex.addItem().width(5)
                        flex.addItem(answerCountLabel)
                        flex.addItem().width(5)
                        flex.addItem(iconImageView).width(15).height(10)
                    }
                }
                flex.addItem(detailView).direction(.column).define{ (flex) in
                    flex.addItem().height(10)
                    flex.addItem(answerView).width(100%).height(50)
                    flex.addItem().height(10)
                    flex.addItem(detailBottomView).direction(.row).justifyContent(.spaceBetween).define{ (flex) in
                        flex.addItem(deleteQuestionButton).size(40)
                        flex.addItem().width(10)
                        flex.addItem(selectionAnswerButton).height(40).grow(1)
                    }
                }
                
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(question: Question) {
        self.question = question
        questionLabel.text = question.text
        print("질문: \(question.text)")
        if let answererCount = question.answerer?.count {
            answerCountLabel.text = "\(answererCount)명참여중"
            guard let textString = answerCountLabel.text else {return}
            let attributedStr = NSMutableAttributedString(string: textString)
            attributedStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 8, weight: .regular), range: (textString as NSString).range(of: "명참여중"))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.white, range: (textString as NSString).range(of:"명참여중"))
            answerCountLabel.attributedText = attributedStr
        }
        
        questionLabel.flex.markDirty()
        answerCountLabel.flex.markDirty()
    }
    
    func configure(methods: Method) {
        questionLabel.text = methods.name
        print("질문: \(methods.name)")
        questionLabel.flex.markDirty()
        
    }
    
    func isExpanded(_ isExpanded: Bool) {
        if isExpanded {
            detailView.flex.display(.flex)
            iconImageView.image = UIImage(systemName: "chevron.up")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage()
            layout()
        } else {
            detailView.flex.display(.none)
            iconImageView.image = UIImage(systemName: "chevron.down")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage()
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
        let count = question?.answerer?.count ?? 0
        print("count: \(count)")
        return question?.answerer?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswerCell.reuseIdentifier, for: indexPath) as! AnswerCell
        
        if selectedIndexPathRow == indexPath.row {
            cell.profileImageView.layer.borderColor = CoffeeOverflowAsset.primaryColor.color.cgColor
        } else {
            cell.profileImageView.layer.borderColor = UIColor.clear.cgColor
        }

        if let profileImage = self.question?.answerer?[indexPath.row].profileImage {
            cell.configure(data: profileImage)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("답변자 선택 : \(indexPath.row)")
        selectedIndexPathRow = indexPath.row
        collectionView.reloadData()
    }
}
