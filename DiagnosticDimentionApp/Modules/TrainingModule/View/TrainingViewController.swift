// TrainingViewController.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// TrainingConstants
enum TrainingConstants {
    // Layout constants
    static let collectionSpacing: CGFloat = 10
    static let headerHeight: CGFloat = 40
}

protocol TrainingCoordinatorProtocol: AnyObject {
    func didSelectTraining(model: TrainingModel)
}

final class TrainingViewController: UIViewController {
    var viewModel: TrainingViewModel!
    weak var coordinator: TrainingCoordinatorProtocol?

    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Training"
        setupBackgroundImage()
        setupCollectionView()
    }

    private func setupBackgroundImage() {
        let backgroundImageView = UIImageView(image: .background)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        view.insertSubview(backgroundImageView, at: 0)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupCollectionView() {
        let spacing = TrainingConstants.collectionSpacing
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing

        let width = view.bounds.width
        let availableWidth = width - spacing * 3
        let cellWidth = availableWidth / 2.1
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.2)
        layout.headerReferenceSize = CGSize(width: width, height: TrainingConstants.headerHeight)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            TrainingCollectionViewCell.self,
            forCellWithReuseIdentifier: TrainingCollectionViewCell.reuseIdentifier
        )
        collectionView.register(
            TrainingSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrainingSectionHeaderView.reuseIdentifier
        )

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: spacing),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -spacing)
        ])
    }
}

extension TrainingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.trainingSections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.trainingSections[section].items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrainingCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? TrainingCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = viewModel.trainingSections[indexPath.section].items[indexPath.item]
        cell.configure(with: model)
        return cell
    }

    // Section header.
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TrainingSectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as? TrainingSectionHeaderView else {
                return UICollectionReusableView()
            }
            let sectionTitle = viewModel.trainingSections[indexPath.section].title
            header.configure(with: sectionTitle)
            return header
        }
        return UICollectionReusableView()
    }
}

extension TrainingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.trainingSections[indexPath.section].items[indexPath.item]
        print("selected \(model)")
        coordinator?.didSelectTraining(model: model)
    }
}
