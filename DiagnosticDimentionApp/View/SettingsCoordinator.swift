//
//  SettingsCoordinator.swift
//  DiagnosticDimentionApp
//
//  Created by Kadyr Maratuly on 13.02.2025.
//

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
        // Презентуем его модально (или пушим, если хотите)
        navigationController.present(settingsVC, animated: true)
    }
    
    // Метод протокола SettingsCoordinatorProtocol
    func didFinishSettings() {
        // Закрываем настройки
        navigationController.dismiss(animated: true, completion: nil)
    }
}
