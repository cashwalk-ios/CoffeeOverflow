//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Nudge on 2023/01/18.
//

import ProjectDescription

public extension TargetDependency {
    static let flexLayout: TargetDependency = .package(product: "FlexLayout")
    static let pinLayout: TargetDependency = .package(product: "PinLayout")
    static let reactorKit: TargetDependency = .package(product: "ReactorKit")
    static let rxSwift: TargetDependency = .package(product: "RxSwift")
    static let rxCocoa: TargetDependency = .package(product: "RxCocoa")
    static let firebaseAuth: TargetDependency = .package(product: "FirebaseAuth")
    static let firebaseMessaging: TargetDependency = .package(product: "FirebaseMessaging")
    static let firebaseStorage: TargetDependency = .package(product: "FirebaseStorage")
    static let firebaseStoreSwift: TargetDependency = .package(product: "FirebaseFirestoreSwift-Beta")
    static let firebaseStore: TargetDependency = .package(product: "FirebaseFirestore")
}

public extension Package {
    static let flexLayout: Package = .remote(
        url: "https://github.com/layoutBox/FlexLayout.git",
        requirement: .upToNextMajor(from: "1.3.25")
      )
    static let pinLayout: Package = .remote(
        url: "https://github.com/layoutBox/PinLayout.git",
        requirement: .upToNextMajor(from: "1.10.0")
      )
    static let reactorKit: Package = .remote(
        url: "https://github.com/ReactorKit/ReactorKit",
        requirement: .upToNextMajor(from: "3.2.0")
      )
    static let rxSwift: Package = .remote(
        url: "https://github.com/ReactiveX/RxSwift.git",
        requirement: .upToNextMajor(from: "6.5.0")
      )
    static let firebase: Package = .remote(
        url: "https://github.com/firebase/firebase-ios-sdk.git",
        requirement: .upToNextMajor(from: "8.0.0")
      )
}


