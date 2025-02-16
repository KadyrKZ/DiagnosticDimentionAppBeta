// SceneDelegate.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let selectedThemeIndex = UserDefaults.standard.integer(forKey: "selectedThemeIndex")
        window.overrideUserInterfaceStyle = (selectedThemeIndex == 1) ? .dark : .light

        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
