// CircularProgressViewModel.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// A view model that manages the progress value and determines the stroke color based on the progress percentage.
final class CircularProgressViewModel {
    // MARK: - Properties

    var progress: CGFloat = 0 {
        didSet {
            // Optionally notify about changes.
        }
    }

    // MARK: - Computed Properties

    var strokeColor: UIColor {
        let percentage = progress * 100.0
        if percentage <= 30 {
            return .green
        } else if percentage <= 55 {
            return .systemYellow
        } else if percentage <= 80 {
            return .orange
        } else {
            return .red
        }
    }
}
