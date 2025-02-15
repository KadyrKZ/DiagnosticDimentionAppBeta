// MainCoordinator.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

final class MainCoordinator: BaseCoordinator {
    private let window: UIWindow
    private let tabBarController: UITabBarController

    private var diagnosticCoordinator: DiagnosticCoordinator?
    private var historyCoordinator: HistoryCoordinator?
    private var trainingCoordinator: TrainingCoordinator?

    init(window: UIWindow) {
        self.window = window
        tabBarController = UITabBarController()
        super.init()
    }

    override func start() {
        let diagnosticNavController = UINavigationController()
        let historyNavController = UINavigationController()
        let trainingNavController = UINavigationController()

        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let diagnosticImage = UIImage(systemName: "waveform.path.ecg", withConfiguration: symbolConfig)
        diagnosticNavController.tabBarItem = UITabBarItem(
            title: "",
            image: diagnosticImage,
            selectedImage: diagnosticImage
        )

        let historyImage = UIImage(systemName: "clock", withConfiguration: symbolConfig)
        historyNavController.tabBarItem = UITabBarItem(title: "", image: historyImage, selectedImage: historyImage)

        let trainingImage = UIImage(systemName: "figure.walk", withConfiguration: symbolConfig)
        trainingNavController.tabBarItem = UITabBarItem(title: "", image: trainingImage, selectedImage: trainingImage)
        tabBarController.tabBar.isTranslucent = true
        tabBarController.tabBar.tintColor = .tabbarIcon

        diagnosticCoordinator = DiagnosticCoordinator(navigationController: diagnosticNavController)
        historyCoordinator = HistoryCoordinator(navigationController: historyNavController)
        trainingCoordinator = TrainingCoordinator(navigationController: trainingNavController)

        diagnosticCoordinator?.start()
        historyCoordinator?.start()
        trainingCoordinator?.start()

        tabBarController.viewControllers = [diagnosticNavController, historyNavController, trainingNavController]
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
