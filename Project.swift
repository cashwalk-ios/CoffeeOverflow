import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let target = Target(name: "CoffeeOverflow",
                    platform: .iOS,
                    product: .app,
                    productName: "CoffeeOverflow",
                    bundleId: "com.CoffeeOverflow",
                    deploymentTarget: .iOS( targetVersion: "16.2", devices: .iphone),
                    infoPlist: .file(path: "CoffeeOverflow/Info.plist"),
                    sources: "CoffeeOverflow/Sources/**",
                    resources: "CoffeeOverflow/Resources/**",
                    dependencies: [.flexLayout,
                                   .pinLayout,
                                   .reactorKit,
                                   .rxSwift,
                                   .rxCocoa,
                                   .firebaseAuth,
                                   .firebaseMessaging,
                                   .firebaseStorage,
                                   .firebaseStoreSwift,
                                   .firebaseStore
                    ],
                    settings: .settings(base: ["GCC_PREPROCESSOR_DEFINITIONS" : "FLEXLAYOUT_SWIFT_PACKAGE=1"])
                )


let project = Project(name: "CoffeeOverflow",
                      organizationName: "com.Cashwalk",
                      packages:
                        [.flexLayout,
                         .pinLayout,
                         .reactorKit,
                         .rxSwift,
                         .firebase],
                        targets: [target])




