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
    let checkIsSignedInUseCase: CheckIsSignedInUseCase

    let loginViewController: LoginViewController
    let mainViewController: MainViewController
}

extension AppDependency {
    static func resolve() -> AppDependency {
    
        // MARK: - DataSource
        let userDefaultsDataSource: UserDefaultsDataSource = UserDefaultsDataSourceImpl()
        let slackDataSource: SlackDataSource = SlackDataSourceImpl()
        let firestoreDataSource: FirestoreDataSource = FirestoreDataSourceImpl()

        // MARK: - Repository
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
        
        // MARK: - UseCase
        let checkIsSignedInUseCase = CheckIsSignedInUseCase(userRepository: userRepository)
        let confirmResponsedCoffeeUseCase = ConfirmResponsedCoffeeUseCase(questionsRepository: questionsRepository)
        let deleteQuestionUseCase = DeleteQuestionUseCase(questionsRepository: questionsRepository)
        let requestCoffeeUseCase = RequestCoffeeUseCase(chatRepository: chatRepository)
        let signInUseCase = SignInUseCase(userRepository: userRepository)
        let selectionAnswerUseCase = SelectionAnswerUseCase(
            userReposiotry: userRepository,
            chatRepository: chatRepository,
            questionsRepository: questionsRepository
        )
        let fetchMyQuestionsUseCase = FetchMyQuestionsUseCase(
            userReposiotry: userRepository,
            questionsRepository: questionsRepository
        )
        let fetchMyCoffeePurchaserUseCase = FetchMyCoffeePurchaserUseCase(
            questionsRepository: questionsRepository,
            userReposiotry: userRepository
        )
        
        // MARK: - Reactor
        //ConfirmResponsedCoffeeUseCase, 
        let mainReactor = MainReactor(
            confirmResponsedCoffeeUseCase: confirmResponsedCoffeeUseCase,
            requestCoffeeUseCase: requestCoffeeUseCase,
            fetchMyCoffeePurchaserUseCase: fetchMyCoffeePurchaserUseCase
            )

        let loginReactor = LoginReactor(signInUseCase: signInUseCase)
        let myQuestionsViewReactor = MyQuestionsViewReactor()

        // MARK: - ViewController
        let myQuestionsViewController = MyQuestionsViewController(
            reactor: myQuestionsViewReactor,
            fetchMyQuestionsUseCase: fetchMyQuestionsUseCase,
            selectionAnswerUseCase: selectionAnswerUseCase,
            deleteQuestionUseCase: deleteQuestionUseCase
        )
//        let mainViewController = MainViewController(reactor: mainReactor, myQuestionsViewController: myQuestionsViewController)
        let mainViewController = MainViewController(reactor: mainReactor)
        let loginViewController = LoginViewController(
            reactor: loginReactor,
            mainViewController: mainViewController
        )
        

        return AppDependency(
            checkIsSignedInUseCase: checkIsSignedInUseCase,
            loginViewController: loginViewController,
            mainViewController: mainViewController
        )
    }
}
