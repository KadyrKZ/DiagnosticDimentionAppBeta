// HistoryBuilder.swift
// Copyright © KadyrKZ. All rights reserved.

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
