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
        view.backgroundColor = .historyPage
        setupCollectionView()
    }

    private func setupCollectionView() {
        let spacing = TrainingConstants.collectionSpacing
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing

        // Calculate cell size for 2 columns.
        let availableWidth = view.frame.width - spacing * 3
        let cellWidth = availableWidth / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.2)

        // Set header size using constant.
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: TrainingConstants.headerHeight)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self

        // Register cell and header view.
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
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -spacing)
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
        coordinator?.didSelectTraining(model: model)
    }
}
