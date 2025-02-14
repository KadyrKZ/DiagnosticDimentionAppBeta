// DiagnosticCoordinator.swift
//
//  Created by Қадыр Маратұлы on 27.02.2024.
//

import Foundation
import UIKit

final class DiagnosticCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController

    // Инициализатор принимает навигационный контроллер
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    // Запуск основного модуля диагностики
    override func start() {
        let diagnosticVC = DiagnosticBuilder().configureModule(coordinator: self)
        navigationController.viewControllers = [diagnosticVC]
        
        // Если требуется показ онбординга, можно добавить здесь вызов showOnboarding()
    }
    
    // Метод для показа результата диагностики
    func showResult(percentage: CGFloat, diagnosis: String) {
        // Создаем контроллер с результатом. CircularResultViewController должен принимать эти параметры.
        let resultVC = CircularResultViewController(percentage: percentage, diagnosis: diagnosis)
        // Презентуем его модально или пушем, в зависимости от требований
        navigationController.present(resultVC, animated: true, completion: nil)
    }
    
    // DiagnosticCoordinator.swift
    func showSettings() {
        let settingsCoord = SettingsCoordinator(navigationController: navigationController)
        add(coordinator: settingsCoord)
        settingsCoord.start()
    }
    
    // Пример метода показа онбординга (если используется)
    func showOnboarding() {
        let onboardingVC = OnboardingBuilder().configureModule()
        onboardingVC.modalPresentationStyle = .overFullScreen
        DispatchQueue.main.async {
            self.navigationController.present(onboardingVC, animated: true) {
                UserDefaults.standard.set(true, forKey: "hasShownOnboarding")
            }
        }
    }
}
