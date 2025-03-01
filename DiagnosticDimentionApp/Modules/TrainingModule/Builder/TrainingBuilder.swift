// TrainingBuilder.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// Protocol for building the training module.
protocol TrainingBuilderProtocol {
    func configureModule(coordinator: TrainingCoordinatorProtocol) -> UIViewController
}

/// Builder for configuring the training module.
final class TrainingBuilder: TrainingBuilderProtocol {
    // MARK: - Module Configuration

    func configureModule(coordinator: TrainingCoordinatorProtocol) -> UIViewController {
        let trainingVC = TrainingViewController()
        trainingVC.viewModel = TrainingViewModel()
        trainingVC.coordinator = coordinator
        return trainingVC
    }
}
