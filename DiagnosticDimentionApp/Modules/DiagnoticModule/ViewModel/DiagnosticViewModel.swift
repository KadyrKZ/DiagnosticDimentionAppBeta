// DiagnosticViewModel.swift
// Copyright © KadyrKZ. All rights reserved.

import Foundation
import UIKit

/// View model for diagnostic operations.
final class DiagnosticViewModel {
    // MARK: - Callbacks

    var onUploadSuccess: (([String: Any]) -> Void)?
    var onUploadFailure: ((Error) -> Void)?

    // MARK: - Methods

    func uploadVideo(videoURL: URL, serverURL: String) {
        print(DiagnosticConstants.startingUploadMessage + videoURL.absoluteString)
        APIService.shared.upload(videoURL: videoURL, to: serverURL) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    print(DiagnosticConstants.uploadSuccessMessage + "\(response)")
                    self?.onUploadSuccess?(response)
                case let .failure(error):
                    print(DiagnosticConstants.uploadErrorMessage + error.localizedDescription)
                    self?.onUploadFailure?(error)
                }
            }
        }
    }
}
