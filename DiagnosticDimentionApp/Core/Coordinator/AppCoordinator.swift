// AppCoordinator.swift
//
//  Created by Қадыр Маратұлы on 27.02.2024.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    private let window: UIWindow
    private var mainCoordinator: MainCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    override func start() {
        mainCoordinator = MainCoordinator(window: window)
        add(coordinator: mainCoordinator!)
        mainCoordinator?.start()
    }
}
