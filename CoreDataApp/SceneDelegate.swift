//
//  SceneDelegate.swift
//  CoreDataApp
//
//  Created by Sveta on 17.12.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let scene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: scene)
            let mainView = CompanyAssembly().build()
            let navVC = UINavigationController(rootViewController: mainView)
            self.window?.rootViewController = navVC
            self.window?.makeKeyAndVisible()
        }
    }
}

