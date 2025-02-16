// TrainingDetailViewController.swift
// Copyright © KadyrKZ. All rights reserved.

import AVKit
import UIKit

/// TrainingDetailConstants
enum TrainingDetailConstants {
    static let videoHeight: CGFloat = 300
    static let sidePadding: CGFloat = 16
}

final class TrainingDetailViewController: UIViewController {
    private let trainingModel: TrainingModel
    private var playerViewController: AVPlayerViewController!

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(trainingModel: TrainingModel) {
        self.trainingModel = trainingModel
        super.init(nibName: nil, bundle: nil)
        title = trainingModel.title
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .button
        setupVideoPlayer()
        setupDescriptionLabel()
    }

    private func setupVideoPlayer() {
        playerViewController = AVPlayerViewController()
        if let videoURL = Bundle.main.url(forResource: trainingModel.videoName, withExtension: "mp4") {
            let player = AVPlayer(url: videoURL)
            playerViewController.player = player
        } else {
            print("Video file not found: \(trainingModel.videoName).mp4")
        }
        addChild(playerViewController)
        view.addSubview(playerViewController.view)
        playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        playerViewController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            playerViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerViewController.view.heightAnchor.constraint(equalToConstant: TrainingDetailConstants.videoHeight)
        ])
    }

    private func setupDescriptionLabel() {
        descriptionLabel.text = trainingModel.description
        view.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: playerViewController.view.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: TrainingDetailConstants.sidePadding
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -TrainingDetailConstants.sidePadding
            ),
            descriptionLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            )
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playerViewController.player?.play()
    }
}
