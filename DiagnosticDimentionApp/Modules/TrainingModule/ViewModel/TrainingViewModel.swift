// TrainingViewModel.swift
// Copyright © KadyrKZ. All rights reserved.

import Foundation

final class TrainingViewModel {
    // Dividing 8 training types into 3 sections.
    let trainingSections: [TrainingSection] = [
        TrainingSection(title: "For Brain", items: [
            TrainingModel(title: "Training 1", imageName: "training1"),
            TrainingModel(title: "Training 2", imageName: "training2"),
            TrainingModel(title: "Training 3", imageName: "training3")
        ]),
        TrainingSection(title: "For Fine Motor Skills", items: [
            TrainingModel(title: "Training 4", imageName: "training4"),
            TrainingModel(title: "Training 5", imageName: "training5")
        ]),
        TrainingSection(title: "For Body", items: [
            TrainingModel(title: "Training 6", imageName: "training6"),
            TrainingModel(title: "Training 7", imageName: "training7"),
            TrainingModel(title: "Training 8", imageName: "training8")
        ])
    ]
}
