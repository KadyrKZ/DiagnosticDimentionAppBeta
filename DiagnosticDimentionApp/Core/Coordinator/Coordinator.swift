// Coordinator.swift
//
//  Created by Қадыр Маратұлы on 27.02.2024.
//

import UIKit

/// Протокол координатора для всего проекта.
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    /// Добавление дочернего координатора.
    func add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    /// Удаление дочернего координатора.
    func remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
