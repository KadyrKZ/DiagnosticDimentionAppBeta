//
//  TrainingViewController.swift
//  DiagnosticDimentionApp
//
//  Created by Kadyr Maratuly on 13.02.2025.
//

import UIKit

protocol TrainingCoordinatorProtocol: AnyObject {
    func didSelectTraining(model: TrainingModel)
}

final class TrainingViewController: UIViewController {
    var viewModel: TrainingViewModel!
    weak var coordinator: TrainingCoordinatorProtocol?
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .historyBackground
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let spacing: CGFloat = 10
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        // Рассчитываем размер ячейки для 2 колонок
        let availableWidth = view.frame.width - spacing * 3
        let cellWidth = availableWidth / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.2)
        
        // Задаем размер заголовка секции
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 40)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Регистрируем ячейку и заголовок секции
        collectionView.register(TrainingCollectionViewCell.self, forCellWithReuseIdentifier: TrainingCollectionViewCell.reuseIdentifier)
        collectionView.register(TrainingSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TrainingSectionHeaderView.reuseIdentifier)
        
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
        return viewModel.trainingSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.trainingSections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainingCollectionViewCell.reuseIdentifier, for: indexPath) as? TrainingCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = viewModel.trainingSections[indexPath.section].items[indexPath.item]
        cell.configure(with: model)
        return cell
    }
    
    // Заголовок секции
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TrainingSectionHeaderView.reuseIdentifier, for: indexPath) as? TrainingSectionHeaderView else {
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
