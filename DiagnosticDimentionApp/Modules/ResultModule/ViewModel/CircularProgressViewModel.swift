//
//  CircularProgressViewModel.swift
//  DetectionDemetia
//
//  Created by Қадыр Маратұлы on 04.02.2025.
//

import UIKit

/// ViewModel для CircularProgressView.
/// Содержит данные о прогрессе и вычисляет цвет индикатора.
final class CircularProgressViewModel {
    var progress: CGFloat = 0 {
        didSet {
            // Можно добавить уведомление об изменении, если требуется
        }
    }
    
    var strokeColor: UIColor {
        let percentage = progress * 100.0
        if percentage <= 30 {
            return UIColor.green
        } else if percentage <= 55 {
            return UIColor.systemYellow
        } else if percentage <= 80 {
            return UIColor.orange
        } else {
            return UIColor.red
        }
    }
}
