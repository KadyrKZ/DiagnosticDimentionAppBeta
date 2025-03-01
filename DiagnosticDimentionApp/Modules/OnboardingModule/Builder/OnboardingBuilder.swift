// OnboardingBuilder.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// Protocol for building the onboarding module.
protocol OnboardingBuilderProtocol {
    func configureModule() -> UIViewController
}

/// Builder for configuring the onboarding module.
final class OnboardingBuilder: OnboardingBuilderProtocol {
    // MARK: - Module Configuration

    func configureModule() -> UIViewController {
        OnboardingViewController()
    }
}
