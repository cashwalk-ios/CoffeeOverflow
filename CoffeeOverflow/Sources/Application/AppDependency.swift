//
//  AppDependency.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/01/31.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import FirebaseAuth

struct AppDependency {
    let mockViewController: MockViewController
}

extension AppDependency {
    static func resolve() -> AppDependency {
        
        let mockReactor = MockReactor(useCase: MockUseCaseImpl())
        
        let mockViewControllor = MockViewController(reactor: mockReactor)
        
        return AppDependency(mockViewController: mockViewControllor)
    }
}
