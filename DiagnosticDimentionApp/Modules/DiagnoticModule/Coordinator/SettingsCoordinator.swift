// SettingsCoordinator.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

final class SettingsCoordinator: BaseCoordinator, SettingsCoordinatorProtocol {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    override func start() {
        let settingsVC = SettingsViewController()
        settingsVC.coordinator = self
        settingsVC.modalPresentationStyle = .overFullScreen
        // Present the settings view controller modally (or push it if desired)
        navigationController.present(settingsVC, animated: true)
    }

    // SettingsCoordinatorProtocol method
    func didFinishSettings() {
        // Dismiss the settings view controller
        navigationController.dismiss(animated: true, completion: nil)
    }
}
