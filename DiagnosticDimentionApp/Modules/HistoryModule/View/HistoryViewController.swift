// HistoryViewController.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// HistoryConstants
enum HistoryConstants {
    static let clearButtonTitle = "Clear"
    static let probabilityPrefix = "Probability: "
    static let diagnosisPrefix = "Diagnosis: "
}

final class HistoryViewController: UITableViewController {
    weak var coordinator: HistoryCoordinator?
    var viewModel: HistoryViewModel!

    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let gearImage = UIImage(systemName: "trash", withConfiguration: symbolConfig)?
            .withRenderingMode(.alwaysTemplate)
        button.setImage(gearImage, for: .normal)
        button.tintColor = UIColor.tabbarIcon
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clearHistoryTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        tableView.backgroundColor = .historyBackground
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.reuseIdentifier)
        let clearBarButton = UIBarButtonItem(customView: clearButton)
        navigationItem.rightBarButtonItem = clearBarButton

        NSLayoutConstraint.activate([
            clearButton.widthAnchor.constraint(equalToConstant: 20),
            clearButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @objc private func clearHistoryTapped() {
        viewModel.clearRecords()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.records.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = viewModel.records[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HistoryTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.configure(with: record)
        return cell
    }
}
