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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(named: "historyPageColor")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: HistoryConstants.clearButtonTitle,
            style: .plain,
            target: self,
            action: #selector(clearHistoryTapped)
        )
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.backgroundColor = .historyBackground
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let dateStr = dateFormatter.string(from: record.date)

        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = """
        \(record.patientName)
        \(HistoryConstants.probabilityPrefix)\(Int(record.probability))%
        \(HistoryConstants.diagnosisPrefix)\(record.diagnosis)
        \(dateStr)
        """
        return cell
    }
}
