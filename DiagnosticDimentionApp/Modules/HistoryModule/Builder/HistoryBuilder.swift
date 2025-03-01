// HistoryBuilder.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// Protocol for building the history module.
protocol HistoryBuilderProtocol {
    func configureModule(coordinator: HistoryCoordinator) -> UIViewController
}

/// Builder for configuring the history module.
final class HistoryBuilder: HistoryBuilderProtocol {
    // MARK: - Module Configuration

    func configureModule(coordinator: HistoryCoordinator) -> UIViewController {
        let historyVC = HistoryViewController()
        historyVC.coordinator = coordinator
        let viewModel = HistoryViewModel()
        historyVC.viewModel = viewModel
        return historyVC
    }
}
