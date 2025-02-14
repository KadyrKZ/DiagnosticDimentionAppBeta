//
//  HistoryViewModel.swift
//  DetectionDemetia
//
//  Created by Қадыр Маратұлы on 06.02.2025.
//

import Foundation

final class HistoryViewModel {
    var records: [DiagnosisRecord] {
        return DataManager.shared.diagnosisResults
    }
    
    func clearRecords() {
        DataManager.shared.clearRecords()
    }
}
