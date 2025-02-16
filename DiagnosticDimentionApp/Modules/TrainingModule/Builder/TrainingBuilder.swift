// TrainingBuilder.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

protocol TrainingBuilderProtocol {
    func configureModule(coordinator: TrainingCoordinatorProtocol) -> UIViewController
}

final class TrainingBuilder: TrainingBuilderProtocol {
    func configureModule(coordinator: TrainingCoordinatorProtocol) -> UIViewController {
        let trainingVC = TrainingViewController()
        trainingVC.viewModel = TrainingViewModel()
        trainingVC.coordinator = coordinator
        return trainingVC
    }
}
