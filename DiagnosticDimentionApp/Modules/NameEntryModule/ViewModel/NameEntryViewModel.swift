// NameEntryViewModel.swift
// Copyright © KadyrKZ. All rights reserved.

import Foundation

final class NameEntryViewModel {
    private let probability: Double
    private let diagnosis: String

    init(probability: Double, diagnosis: String) {
        self.probability = probability
        self.diagnosis = diagnosis
    }

    /// Saves a record with the entered name.
    func saveRecord(with patientName: String) {
        let trimmedName = patientName.trimmingCharacters(in: .whitespacesAndNewlines)
        let finalName = trimmedName.isEmpty ? "No Name" : trimmedName
        let record = DiagnosisRecord(
            patientName: finalName,
            date: Date(),
            probability: probability,
            diagnosis: diagnosis
        )
        print("Saving record: \(record)")
        DataManager.shared.addRecord(record)
    }
}
