//
//  TrainingCoordinator.swift
//  DiagnosticDimentionApp
//
//  Created by Kadyr Maratuly on 13.02.2025.
//

import UIKit

final class TrainingCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() {
        let trainingVC = TrainingBuilder().configureModule()
        navigationController.viewControllers = [trainingVC]
    }
}
