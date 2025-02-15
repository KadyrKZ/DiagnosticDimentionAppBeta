// HistoryViewModel.swift
// Copyright © KadyrKZ. All rights reserved.

import Foundation

final class HistoryViewModel {
    var records: [DiagnosisRecord] {
        DataManager.shared.diagnosisResults
    }

    func clearRecords() {
        DataManager.shared.clearRecords()
    }
}
