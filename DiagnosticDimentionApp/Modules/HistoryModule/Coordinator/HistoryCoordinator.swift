//
//  HistoryCoordinator.swift
//  DetectionDemetia
//
//  Created by Қадыр Маратұлы on 06.02.2025.
//

import UIKit

final class HistoryCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
         self.navigationController = navigationController
         super.init()
    }
    
    override func start() {
         let historyVC = HistoryBuilder().configureModule(coordinator: self)
         navigationController.viewControllers = [historyVC]
    }
}
