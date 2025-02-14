//
//  DiagnosticViewModel.swift
//  DetectionDemetia
//
//  Created by Қадыр Маратұлы on 04.02.2025.
//

import Foundation
import UIKit

final class DiagnosticViewModel {
    var onUploadSuccess: (([String: Any]) -> Void)?
    var onUploadFailure: ((Error) -> Void)?
    
    func uploadVideo(videoURL: URL, serverURL: String) {
        print("Начинаем загрузку видео: \(videoURL.absoluteString)")
        APIService.shared.upload(videoURL: videoURL, to: serverURL) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("Загрузка видео прошла успешно. Ответ сервера: \(response)")
                    self?.onUploadSuccess?(response)
                case .failure(let error):
                    print("Ошибка загрузки видео: \(error.localizedDescription)")
                    self?.onUploadFailure?(error)
                }
            }
        }
    }
}
