//
//  DiagnosticViewController.swift
//  DetectionDemetia
//
//  Created by Қадыр Маратұлы on 03.02.2025.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class DiagnosticViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Координатор
    weak var coordinator: DiagnosticCoordinator?

    // MARK: - UI элементы
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Диагностика"
        label.font = UIFont(name: "InriaSans-Bold", size: 40)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let instructionsLabel: UILabel = {
        let label = UILabel()
        label.text = """
                         Инструкции:
        
        1. Нажмите "Записать видео" для записи.
        2. Следуйте рекомендациям (освещение, угол).
        3. Дождитесь результатов диагностики.
        """
        label.font = UIFont(name: "InriaSans-Regular", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let recordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Запись видео", for: .normal)
        button.titleLabel?.font = UIFont(name: "InriaSans-Bold", size: 16)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 34
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let galleryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выбрать видео из галереи", for: .normal)
        button.titleLabel?.font = UIFont(name: "InriaSans-Bold", size: 16)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.layer.cornerRadius = 34
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Константы
    private let serverURL = "http://neuroalz-api-292378482352.us-central1.run.app/predict"
    
    // MARK: - ViewModel (MVVM)
    var viewModel: DiagnosticViewModel!
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupUI()
        setupBindings()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Настройки", style: .plain, target: self, action: #selector(settingsTapped))
    }
    
    // MARK: - Настройка UI
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(instructionsLabel)
        view.addSubview(recordButton)
        view.addSubview(galleryButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            instructionsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            recordButton.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 180),
            recordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            recordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            recordButton.heightAnchor.constraint(equalToConstant: 67),
            
            galleryButton.topAnchor.constraint(equalTo: recordButton.bottomAnchor, constant: 20),
            galleryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            galleryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            galleryButton.heightAnchor.constraint(equalToConstant: 67)
        ])
        
        recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        galleryButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)
    }
    
    private func setupBackgroundImage() {
        // Создаем UIImageView с нужным изображением (убедитесь, что файл изображения добавлен в Assets.xcassets)
        let backgroundImageView = UIImageView(image: UIImage(named: "background"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем изображение на задний план
        view.insertSubview(backgroundImageView, at: 0)
        
        // Настраиваем Auto Layout так, чтобы UIImageView занимал весь экран
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Настройка биндингов
    private func setupBindings() {
        viewModel.onUploadSuccess = { [weak self] response in
            guard let self = self else { return }
            let rawProb = response["probability"] as? Double ?? 0.0
            let diagnosis = response["diagnosis"] as? String ?? "Unknown"
            let percentage = CGFloat(rawProb * 100)
            // Закрываем загрузочный экран, если он презентован
            self.dismiss(animated: true) {
                // После этого вызываем метод координатора для показа результата
                self.coordinator?.showResult(percentage: percentage, diagnosis: diagnosis)
            }
        }
        viewModel.onUploadFailure = { [weak self] error in
            self?.dismiss(animated: true) {
                self?.showAlert(title: "Ошибка загрузки", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Действия
    
    @objc private func recordButtonTapped() {
        // Проверка доступности камеры
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showAlert(title: "Камера недоступна", message: "Это устройство не поддерживает запись видео.")
            return
        }
        
        // Получаем список доступных типов медиа для камеры
        guard let availableTypes = UIImagePickerController.availableMediaTypes(for: .camera),
              availableTypes.contains(UTType.movie.identifier) else {
            showAlert(title: "Запись видео недоступна", message: "На этом устройстве недоступна запись видео.")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.mediaTypes = [UTType.movie.identifier]
        imagePicker.videoQuality = .typeHigh
        present(imagePicker, animated: true)
    }

    @objc private func settingsTapped() {
        coordinator?.showSettings()
    }
    
    @objc private func galleryButtonTapped() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            showAlert(title: "Галерея недоступна", message: "Доступ к галерее невозможен.")
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [UTType.movie.identifier]
        present(imagePicker, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoURL = info[.mediaURL] as? URL {
            picker.dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                // Создаем и презентуем LoadingViewController
                let loadingVC = LoadingViewController()
                loadingVC.modalPresentationStyle = .overFullScreen
                self.present(loadingVC, animated: true) {
                    // После показа загрузочного экрана запускаем загрузку видео
                    self.viewModel.uploadVideo(videoURL: videoURL, serverURL: self.serverURL)
                }
            }
        } else {
            picker.dismiss(animated: true)
        }
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    // MARK: - Вспомогательные методы
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}
