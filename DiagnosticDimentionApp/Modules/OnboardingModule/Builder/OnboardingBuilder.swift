// OnboardingBuilder.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

protocol OnboardingBuilderProtocol {
    func configureModule() -> UIViewController
}

final class OnboardingBuilder: OnboardingBuilderProtocol {
    func configureModule() -> UIViewController {
        OnboardingViewController()
    }
}
