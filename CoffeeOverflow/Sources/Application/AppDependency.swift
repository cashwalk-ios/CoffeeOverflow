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
    
        let userDefaultsDataSource: UserDefaultsDataSource = UserDefaultsDataSourceImpl()
        let slackDataSource: SlackDataSource = SlackDataSourceImpl()
        let firestoreDataSource: FirestoreDataSource = FirestoreDataSourceImpl()

        let userRepository: UserReposiotry = UserRepositoryImpl(
            slackDataSource: slackDataSource,
            firestoreDataSource: firestoreDataSource,
            userDefaultsDataSource: userDefaultsDataSource
        )
        let questionsRepository: QuestionsRepository = QuestionsRepositoryImpl(
            slackDataSource: slackDataSource,
            firestoreDataSource: firestoreDataSource
        )
        let chatRepository: ChatRepository = ChatRepositoryImpl(slackDataSource: slackDataSource)
        
        let useCase: SignInUseCase = SignInUseCase(userRepository: userRepository)
        
        let mainReactor = MainReactor()
        let loginReactor = LoginReactor()

        let mainViewController = MainViewController(reactor: mainReactor)
        let loginViewController = LoginViewController(
            reactor: loginReactor,
            view: mainViewController
        )
        
        return AppDependency(viewController: loginViewController)
    }
}
