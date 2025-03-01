// TrainingViewModel.swift
// Copyright © KadyrKZ. All rights reserved.

import Foundation

/// View model for managing training sections.
final class TrainingViewModel {
    // MARK: - Properties

    let trainingSections: [TrainingSection] = [
        TrainingSection(title: "For Brain", items: [
            TrainingModel(
                title: "Training Walking",
                imageName: "traingMindImage",
                videoName: "trainingwalking",
                description: """
                This Parkinson’s exercise, known as tandem walking, improves balance and coordination. \
                Focus on a fixed point ahead, placing your heel directly in front of the opposite \
                foot’s toe with each step. Repeat for 20 steps to enhance stability and mobility.
                """

            ),
        ]),
        TrainingSection(title: "For Fine Motor Skills", items: [
            TrainingModel(
                title: "Prayer Stretch",
                imageName: "trainingFineImage",
                videoName: "trainingFingers",
                description: """
                This exercise for Parkinson’s involves lacing fingers together, inverting the hands, \ 
                and lifting the elbows to stretch the shoulders dynamically. \
                It can also be done statically by stretching one arm at a time, holding for 10–30 seconds to improve \
                flexibility.
                """
            ),
            TrainingModel(
                title: "Open Hand spreads",
                imageName: "trainingFineImage",
                videoName: "trainingFingers2",
                description: """
                The open hand spreads exercise helps reactivate hand muscles and improve dexterity for \
                Parkinson’s. Spread fingers wide, then bring them back together. \
                Perform with palms up, elbows straight, and wrists extended. This can be done in various \
                positions for flexibility.
                """
            ),
            TrainingModel(
                title: "Finger flipping",
                imageName: "trainingFineImage",
                videoName: "trainingFingers3",
                description: """
                This Parkinson’s exercise, isolated finger flicks, helps improve finger dexterity \
                and coordination. Flick each finger individually—starting with the index, followed \
                by the middle, ring, and little finger. \
                Perform with both hands simultaneously or one at a time to enhance fine motor control
                """
            )
        ]),
        TrainingSection(title: "For Body", items: [
            TrainingModel(
                title: "Training Walking",
                imageName: "trainingWalkingImage",
                videoName: "trainingwalking",
                description: """
                "This Parkinson’s exercise, known as tandem walking, improves balance and coordination. \
                Focus on a fixed point ahead, placing your heel directly in front of the opposite \
                foot’s toe with each step. Repeat for 20 steps to enhance stability and mobility.
                """
            ),
        ])
    ]
}
