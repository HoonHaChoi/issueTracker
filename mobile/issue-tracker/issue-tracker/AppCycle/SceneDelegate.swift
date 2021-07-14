//
//  SceneDelegate.swift
//  issue-tracker
//
//  Created by HOONHA CHOI on 2021/06/08.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appDependency = AppDependency()
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let screen = (scene as? UIWindowScene) else { return }

        let navigationController = UINavigationController()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = screen
        window?.rootViewController = navigationController
        appCoordinator = AppCoordinator(navigation: navigationController,
                                        dependency: appDependency)
        appCoordinator?.start()
        window?.makeKeyAndVisible()
    }
}
