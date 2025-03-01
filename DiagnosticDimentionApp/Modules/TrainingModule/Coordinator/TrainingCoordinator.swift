// TrainingCoordinator.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// Protocol for handling training coordination.
protocol TrainingCoordinatorProtocol: AnyObject {
    func didSelectTraining(model: TrainingModel)
}

/// Coordinator for managing the training flow.
final class TrainingCoordinator: BaseCoordinator, TrainingCoordinatorProtocol {
    // MARK: - Properties

    private let navigationController: UINavigationController

    // MARK: - Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    // MARK: - Coordinator Methods

    override func start() {
        let trainingVC = TrainingBuilder().configureModule(coordinator: self)
        navigationController.viewControllers = [trainingVC]
    }

    func didSelectTraining(model: TrainingModel) {
        let detailVC = TrainingDetailViewController(trainingModel: model)
        DispatchQueue.main.async {
            self.navigationController.pushViewController(detailVC, animated: true)
        }
    }
}
