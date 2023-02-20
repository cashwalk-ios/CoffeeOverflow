//
//  UIImage + .swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/19.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
