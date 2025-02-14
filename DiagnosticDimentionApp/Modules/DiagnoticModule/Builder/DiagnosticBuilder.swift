// MainBuilder.swift
//
//  Created by Қадыр Маратұлы on 27.02.2024.
//

import UIKit

protocol DiagnosticBuilderProtocol {
    func configureModule(coordinator: DiagnosticCoordinator) -> UIViewController
}

final class DiagnosticBuilder: DiagnosticBuilderProtocol {
    func configureModule(coordinator: DiagnosticCoordinator) -> UIViewController {
        let diagnosticVC = DiagnosticViewController()
        diagnosticVC.coordinator = coordinator
        // Настраиваем MVVM: создаем ViewModel и передаем его контроллеру.
        let diagnosticVM = DiagnosticViewModel()
        diagnosticVC.viewModel = diagnosticVM
        return diagnosticVC
    }
}
