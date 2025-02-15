// TrainingBuilder.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

protocol TrainingBuilderProtocol {
    func configureModule() -> UIViewController
}

final class TrainingBuilder: TrainingBuilderProtocol {
    func configureModule() -> UIViewController {
        let trainingVC = TrainingViewController()
        let viewModel = TrainingViewModel()
        trainingVC.viewModel = viewModel
        return trainingVC
    }
}
