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
    let viewController: LoginViewController
}

extension AppDependency {
    static func resolve() -> AppDependency {
    
        let mockUsecase = MockUseCase()
        let mockReactor = MockReactor(useCase: mockUsecase)
        let mockViewControllor = MockViewController(reactor: mockReactor)
        
        let mainReactor = MainReactor(useCase: mockUsecase)
        let mainViewController = MainViewController(reactor: mainReactor)
        
        let loginReactor = LoginReactor(useCase: mockUsecase)
        let loginViewController = LoginViewController(reactor: loginReactor,
                                                      view: mainViewController)
        
        return AppDependency(viewController: loginViewController)
    }
}
