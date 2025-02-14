//
//  NameEntryBuilder.swift
//  DiagnosticDimentionApp
//
//  Created by Kadyr Maratuly on 12.02.2025.
//

import UIKit

protocol NameEntryBuilderProtocol {
    func configureModule(probability: Double, diagnosis: String, coordinator: NameEntryCoordinatorProtocol) -> UIViewController
}

final class NameEntryBuilder: NameEntryBuilderProtocol {
    func configureModule(probability: Double, diagnosis: String, coordinator: NameEntryCoordinatorProtocol) -> UIViewController {
        let viewModel = NameEntryViewModel(probability: probability, diagnosis: diagnosis)
        let nameEntryVC = NameEntryViewController(viewModel: viewModel, coordinator: coordinator)
        // При необходимости можно обернуть в UINavigationController:
        // let navController = UINavigationController(rootViewController: nameEntryVC)
        return nameEntryVC
    }
}
