// TrainingViewController.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// View controller for displaying training items.
final class TrainingViewController: UIViewController {
    // MARK: - Properties

    var viewModel: TrainingViewModel!
    weak var coordinator: (TrainingCoordinatorProtocol & AnyObject)?

    private var collectionView: UICollectionView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = TrainingConstants.title
        setupBackgroundImage()
        setupCollectionView()
    }

    // MARK: - UI Setup

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

// MARK: - UICollectionViewDataSource

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

// MARK: - UICollectionViewDelegate

extension TrainingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.trainingSections[indexPath.section].items[indexPath.item]
        print("selected \(model)")
        coordinator?.didSelectTraining(model: model)
    }
}
