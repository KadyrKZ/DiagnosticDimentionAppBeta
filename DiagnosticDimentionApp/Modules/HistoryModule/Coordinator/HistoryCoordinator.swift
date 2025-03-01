// HistoryCoordinator.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// Coordinator for managing the history flow.
final class HistoryCoordinator: BaseCoordinator {
    // MARK: - Properties

    private let navigationController: UINavigationController

    // MARK: - Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    // MARK: - Flow Start

    override func start() {
        let historyVC = HistoryBuilder().configureModule(coordinator: self)
        navigationController.viewControllers = [historyVC]
    }
}
