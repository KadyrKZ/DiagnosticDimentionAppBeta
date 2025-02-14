//
//  TrainingBuilder.swift
//  DiagnosticDimentionApp
//
//  Created by Kadyr Maratuly on 13.02.2025.
//

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
