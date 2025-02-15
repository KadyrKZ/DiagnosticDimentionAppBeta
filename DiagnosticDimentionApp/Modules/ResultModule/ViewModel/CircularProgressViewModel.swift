// CircularProgressViewModel.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

final class CircularProgressViewModel {
    var progress: CGFloat = 0 {
        didSet {
            // Optionally notify about changes.
        }
    }

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
