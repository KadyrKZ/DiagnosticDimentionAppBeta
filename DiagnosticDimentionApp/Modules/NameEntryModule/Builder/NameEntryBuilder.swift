// NameEntryBuilder.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

protocol NameEntryBuilderProtocol {
    func configureModule(probability: Double, diagnosis: String, coordinator: NameEntryCoordinatorProtocol)
        -> UIViewController
}

final class NameEntryBuilder: NameEntryBuilderProtocol {
    func configureModule(
        probability: Double,
        diagnosis: String,
        coordinator: NameEntryCoordinatorProtocol
    ) -> UIViewController {
        let viewModel = NameEntryViewModel(probability: probability, diagnosis: diagnosis)
        let nameEntryVC = NameEntryViewController(viewModel: viewModel, coordinator: coordinator)
        return nameEntryVC
    }
}
