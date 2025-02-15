// BaseCoordinator.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// The coordinator's base class for inheritance.
class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    func start() {
        fatalError("Child coordinators must implement start()")
    }
}
