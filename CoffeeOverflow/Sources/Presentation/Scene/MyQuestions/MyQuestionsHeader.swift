//
//  MyQuestionsHeader.swift
//  CoffeeOverflow
//
//  Created by lovecat on 2023/02/02.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import UIKit

class MyQuestionsHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = "MyQuestionsHeader"
    static let height: CGFloat = 100
    
    fileprivate let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
        titleLabel.sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Center the label vertically. Note that we don't need to specify the size, it has already be adjusted in init().
        titleLabel.pin.horizontally(pin.safeArea.left + 20).vCenter()
    }
}
