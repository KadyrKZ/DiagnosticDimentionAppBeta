// TrainingCoordinator.swift
// Copyright © KadyrKZ. All rights reserved.

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
