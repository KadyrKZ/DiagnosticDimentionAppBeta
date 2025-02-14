//
//  TrainingViewModel.swift
//  DiagnosticDimentionApp
//
//  Created by Kadyr Maratuly on 13.02.2025.
//

import Foundation

final class TrainingViewModel {
    // Разбиваем 8 видов тренировок на 3 секции
    let trainingSections: [TrainingSection] = [
        TrainingSection(title: "Для мозга", items: [
            TrainingModel(title: "Тренировка 1", imageName: "training1"),
            TrainingModel(title: "Тренировка 2", imageName: "training2"),
            TrainingModel(title: "Тренировка 3", imageName: "training3")
        ]),
        TrainingSection(title: "Для мелкой моторики", items: [
            TrainingModel(title: "Тренировка 4", imageName: "training4"),
            TrainingModel(title: "Тренировка 5", imageName: "training5")
        ]),
        TrainingSection(title: "Для тела", items: [
            TrainingModel(title: "Тренировка 6", imageName: "training6"),
            TrainingModel(title: "Тренировка 7", imageName: "training7"),
            TrainingModel(title: "Тренировка 8", imageName: "training8")
        ])
    ]
}
