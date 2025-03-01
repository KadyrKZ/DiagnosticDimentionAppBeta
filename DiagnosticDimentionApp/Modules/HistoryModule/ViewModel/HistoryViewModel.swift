// HistoryViewModel.swift
// Copyright © KadyrKZ. All rights reserved.

import Foundation

/// View model for managing diagnosis history records.
final class HistoryViewModel {
    // MARK: - Properties

    var records: [DiagnosisRecord] {
        DataManager.shared.diagnosisResults
    }

    // MARK: - Methods

    func clearRecords() {
        DataManager.shared.clearRecords()
    }
}
