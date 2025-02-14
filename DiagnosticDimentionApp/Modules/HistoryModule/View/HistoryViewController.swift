//
//  HistoryViewController.swift
//  DetectionDemetia
//
//  Created by [Ваше Имя] on 30.01.2025.
//

import UIKit

final class HistoryViewController: UITableViewController {
    weak var coordinator: HistoryCoordinator?
    var viewModel: HistoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(named: "historyPageColor")
    
     
        //title = "История"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Очистить", style: .plain, target: self, action: #selector(clearHistoryTapped))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.backgroundColor = .historyBackground
    }

    
    @objc private func clearHistoryTapped() {
        viewModel.clearRecords()
        tableView.reloadData()
    }
    
    // MARK: - TableView Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.records.count
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
        Вероятность: \(Int(record.probability))%
        Диагноз: \(record.diagnosis)
        \(dateStr)
        """
        return cell
    }
}
