//
//  AppDelegate.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 28/05/2019.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainController = UsersViewController() as UsersViewController
        let navigationController = UINavigationController(rootViewController: mainController)
        setupNavigationBar(navigationController: navigationController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func setupNavigationBar(navigationController: UINavigationController) {
        
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isHidden = false
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
//        navigationController.navigationBar.layer.masksToBounds = false
//        navigationController.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
//        navigationController.navigationBar.layer.shadowOpacity = 0.9
//        navigationController.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
//        navigationController.navigationBar.layer.shadowRadius = 4

    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

