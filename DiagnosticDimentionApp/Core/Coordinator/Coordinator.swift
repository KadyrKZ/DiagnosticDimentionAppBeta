// Coordinator.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// Coordinator's protocol for the entire project.
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    // Adding a child coordinator.
    func add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    // Deleting a child coordinator.
    func remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
