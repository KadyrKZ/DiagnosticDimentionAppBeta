import Foundation

final class DataManager {
    static let shared = DataManager()
    
    private(set) var diagnosisResults: [DiagnosisRecord] = []
    
    func addRecord(_ record: DiagnosisRecord) {
        diagnosisResults.append(record)
    }
    
    func clearRecords() {
        diagnosisResults.removeAll()
    }
}
