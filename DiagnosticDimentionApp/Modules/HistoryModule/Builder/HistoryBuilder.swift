//
//  HistoryBuilder.swift
//  DetectionDemetia
//
//  Created by Қадыр Маратұлы on 06.02.2025.
//

import UIKit

protocol HistoryBuilderProtocol {
    func configureModule(coordinator: HistoryCoordinator) -> UIViewController
}

final class HistoryBuilder: HistoryBuilderProtocol {
    func configureModule(coordinator: HistoryCoordinator) -> UIViewController {
        let historyVC = HistoryViewController()
        historyVC.coordinator = coordinator
        let viewModel = HistoryViewModel()
        historyVC.viewModel = viewModel
        return historyVC
    }
}
