// AppCoordinator.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

final class AppCoordinator: BaseCoordinator {
    private let window: UIWindow
    private var mainCoordinator: MainCoordinator?

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    override func start() {
        let mainCoordinator = MainCoordinator(window: window)
        self.mainCoordinator = mainCoordinator
        add(coordinator: mainCoordinator)
        mainCoordinator.start()
    }
}
