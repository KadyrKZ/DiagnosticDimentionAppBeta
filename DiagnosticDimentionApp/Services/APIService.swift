//
//  APIService.swift
//  AlzheimerDetectionApp
//
//  Created by [Ваше Имя] on 25.01.2025.
//

import Foundation

final class APIService {
    
    static let shared = APIService()
    private init() { }
    
    /// Загружает видео по URL на сервер по заданному адресу.
    /// - Parameters:
    ///   - videoURL: Локальный URL видеофайла.
    ///   - serverURL: Строка URL сервера.
    ///   - completion: Замыкание с результатом: успешным (JSON-словарь) или ошибкой.
    func upload(videoURL: URL,
                to serverURL: String,
                completion: @escaping (Result<[String: Any], Error>) -> Void) {
        
        // Проверка корректности URL сервера.
        guard let url = URL(string: serverURL) else {
            DispatchQueue.main.async {
                completion(.failure(URLError(.badURL)))
            }
            return
        }
        
        // Попытка загрузить данные видео. Для больших файлов лучше использовать потоковую передачу.
        guard let videoData = try? Data(contentsOf: videoURL) else {
            DispatchQueue.main.async {
                completion(.failure(URLError(.cannotLoadFromNetwork)))
            }
            return
        }
        
        // Создаем запрос.
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Генерируем уникальную границу для multipart/form-data.
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Формируем тело запроса.
        let body = createRequestBody(with: videoData, filename: videoURL.lastPathComponent, boundary: boundary)
        request.httpBody = body
        
        // (Опционально) Устанавливаем заголовок Content-Length.
        request.setValue("\(body.count)", forHTTPHeaderField: "Content-Length")
        
        // Выполняем запрос.
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Переходим на главный поток для вызова completion.
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data,
                      let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonResponse = jsonObject as? [String: Any] {
                        completion(.success(jsonResponse))
                    } else {
                        completion(.failure(URLError(.cannotParseResponse)))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    /// Формирует тело запроса для отправки файла по протоколу multipart/form-data.
    /// - Parameters:
    ///   - videoData: Данные видеофайла.
    ///   - filename: Имя файла.
    ///   - boundary: Граница для разделения частей запроса.
    /// - Returns: Сформированные данные тела запроса.
    private func createRequestBody(with videoData: Data, filename: String, boundary: String) -> Data {
        var body = Data()
        let mimetype = "video/mp4"  // Предполагаем, что видео в формате MP4.
        
        // Начало части с видеофайлом.
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"video\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
        body.append(videoData)
        body.append("\r\n".data(using: .utf8)!)
        
        // Завершающая граница.
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }
}
