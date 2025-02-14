//
//  NameEntryViewModel.swift
//  DiagnosticDimentionApp
//
//  Created by Kadyr Maratuly on 12.02.2025.
//

import Foundation

final class NameEntryViewModel {
    private let probability: Double
    private let diagnosis: String
    
    init(probability: Double, diagnosis: String) {
        self.probability = probability
        self.diagnosis = diagnosis
    }
    
    /// Сохраняет запись с введённым именем.
    func saveRecord(with patientName: String) {
        let trimmedName = patientName.trimmingCharacters(in: .whitespacesAndNewlines)
        let finalName = trimmedName.isEmpty ? "Без имени" : trimmedName
        let record = DiagnosisRecord(
            patientName: finalName,
            date: Date(),
            probability: probability,
            diagnosis: diagnosis
        )
        DataManager.shared.addRecord(record)
    }
}
