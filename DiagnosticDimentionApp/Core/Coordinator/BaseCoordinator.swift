// BaseCoordinator.swift
//
//  Created by Қадыр Маратұлы on 27.02.2024.
//

import UIKit

/// Базовый класс координатора для наследования.
class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    func start() {
        fatalError("Child coordinators must implement start()")
    }
}
