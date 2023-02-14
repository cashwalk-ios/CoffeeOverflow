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
    func putAnswerer(ask: AskDTO) async throws
    func deleteAsk(ask: AskDTO) async throws
    func fetchAsks() async throws -> [AskDTO]
}
