//
//  GoogleInfoPlistScripts.swift
//  ProjectDescriptionHelpers
//
//  Created by Nudge on 2023/02/14.
//

import ProjectDescription

extension TargetScript {
    public static let googleInfoPlistScripts = TargetScript.pre(
        script: """
                cp -r "$SRCROOT/CoffeeOverflow/GoogleService-Info.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"
                """,
        name: "GoogleService-Info.plist",
        basedOnDependencyAnalysis: false
    )
}
