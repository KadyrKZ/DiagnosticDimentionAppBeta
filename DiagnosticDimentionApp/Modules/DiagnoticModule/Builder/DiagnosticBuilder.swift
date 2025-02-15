// DiagnosticBuilder.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

protocol DiagnosticBuilderProtocol {
    func configureModule(coordinator: DiagnosticCoordinator) -> UIViewController
}

final class DiagnosticBuilder: DiagnosticBuilderProtocol {
    func configureModule(coordinator: DiagnosticCoordinator) -> UIViewController {
        let diagnosticVC = DiagnosticViewController()
        diagnosticVC.coordinator = coordinator
        let diagnosticVM = DiagnosticViewModel()
        diagnosticVC.viewModel = diagnosticVM
        return diagnosticVC
    }
}
