import UIKit
import FirebaseCore
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        FirebaseApp.configure()
        
        let appDependency = AppDependency.resolve()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if appDependency.checkIsSignedInUseCase.excute() {
            window?.rootViewController = appDependency.mainViewController
        } else {
            window?.rootViewController = appDependency.loginViewController
        }
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:] ) -> Bool {
        var handled: Bool
        
        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
            return true
        }
        // Handle other custom URL types.
        // If not handled by this app, return false.
        return false
    
    }
}

