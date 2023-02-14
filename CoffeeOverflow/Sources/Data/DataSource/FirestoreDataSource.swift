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
    func insertUser(user: UserDTO) async throws
    func selectAnswerer(question: QuestionDTO) async throws // 질문자 채택 -> 질문 업데이트
    func deleteAsk(question: QuestionDTO) async throws
    func fetchAsks() async throws -> [QuestionDTO]
}
