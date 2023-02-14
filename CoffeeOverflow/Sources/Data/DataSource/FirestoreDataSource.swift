//
//  FirestoreDataSource.swift
//  CoffeeOverflow
//
//  Created by Nudge on 2023/02/13.
//  Copyright © 2023 com.Cashwalk. All rights reserved.
//

import Foundation
import RxSwift

protocol FirestoreDataSource {
    func insertUser(user: UserDTO) async
    func selectAnswerer(question: QuestionDTO) async // 질문자 채택 -> 질문 업데이트
    func deleteQuestion(question: QuestionDTO) async
    func fetchQuestions() async throws -> [QuestionDTO]?
}
