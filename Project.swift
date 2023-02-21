import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let target = Target(
    name: "CoffeeOverflow",
    platform: .iOS,
    product: .app,
    productName: "CoffeeOverflow",
    bundleId: "com.CoffeeOverflow",
    deploymentTarget: .iOS( targetVersion: "16.2", devices: .iphone),
    infoPlist: .file(path: "CoffeeOverflow/Info.plist"),
    sources: "CoffeeOverflow/Sources/**",
    resources: "CoffeeOverflow/Resources/**",
    scripts: [.googleInfoPlistScripts],
    dependencies: [
        .flexLayout,
        .pinLayout,
        .reactorKit,
        .rxSwift,
        .rxCocoa,
        .firebaseAuth,
        .firebaseMessaging,
        .firebaseStorage,
        .firebaseStoreSwift,
        .firebaseStore,
        .moya,
        .rxMoya,
        .googleSingIn,
        .rxGesture
    ],
    settings: .settings(base: [
        "GCC_PREPROCESSOR_DEFINITIONS" : "FLEXLAYOUT_SWIFT_PACKAGE=1"
    ])
)


let project = Project(
    name: "CoffeeOverflow",
    organizationName: "com.Cashwalk",
    packages: [
            .flexLayout,
            .pinLayout,
            .reactorKit,
            .rxSwift,
            .firebase,
            .moya,
            .googleSingIn,
            .rxGesture
        ],
    settings: .settings(
        base: SettingsDictionary()
            .codeSignIdentityAppleDevelopment()
            .automaticCodeSigning(devTeam: "TTF9NC4TZ7"),
        configurations: [
            .debug(name: "Debug", xcconfig: .relativeToRoot("Configuration/env.xcconfig")),
            .release(name: "Release", xcconfig: .relativeToRoot("Configuration/env.xcconfig"))
        ]
    ),
    targets: [target]
)
