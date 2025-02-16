// TrainingCoordinator.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

final class TrainingCoordinator: BaseCoordinator, TrainingCoordinatorProtocol {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    override func start() {
        let trainingVC = TrainingBuilder().configureModule(coordinator: self)
        navigationController.viewControllers = [trainingVC]
    }

    func didSelectTraining(model: TrainingModel) {
        print("TrainingCoordinator: didSelectTraining called with model: \(model)")
        let detailVC = TrainingDetailViewController(trainingModel: model)
        DispatchQueue.main.async {
            self.navigationController.pushViewController(detailVC, animated: true)
        }
    }
}
