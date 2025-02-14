//
//  OnboardingBuilder.swift
//  DiagnosticDimentionApp
//
//  Created by Kadyr Maratuly on 12.02.2025.
//

import UIKit

protocol OnboardingBuilderProtocol {
    func configureModule() -> UIViewController
}

final class OnboardingBuilder: OnboardingBuilderProtocol {
    func configureModule() -> UIViewController {
        return OnboardingViewController()
    }
}
