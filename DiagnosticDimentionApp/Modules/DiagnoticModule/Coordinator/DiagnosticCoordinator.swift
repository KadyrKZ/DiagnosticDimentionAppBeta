// DiagnosticCoordinator.swift
// Copyright © KadyrKZ. All rights reserved.

import Foundation
import UIKit

final class DiagnosticCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    override func start() {
        let diagnosticVC = DiagnosticBuilder().configureModule(coordinator: self)
        navigationController.viewControllers = [diagnosticVC]
    }

    func showResult(percentage: CGFloat, diagnosis: String) {
        let resultVC = CircularResultViewController(percentage: percentage, diagnosis: diagnosis)
        navigationController.present(resultVC, animated: true, completion: nil)
    }

    func showSettings() {
        let settingsCoord = SettingsCoordinator(navigationController: navigationController)
        add(coordinator: settingsCoord)
        settingsCoord.start()
    }

    func showOnboarding() {
        let onboardingVC = OnboardingBuilder().configureModule()
        onboardingVC.modalPresentationStyle = .overFullScreen
        DispatchQueue.main.async {
            self.navigationController.present(onboardingVC, animated: true) {
                UserDefaults.standard.set(true, forKey: "hasShownOnboarding")
            }
        }
    }
}
