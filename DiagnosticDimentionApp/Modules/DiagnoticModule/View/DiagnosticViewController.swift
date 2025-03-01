// DiagnosticViewController.swift
// Copyright © KadyrKZ. All rights reserved.

import AVKit
import Localize_Swift
import MobileCoreServices
import UIKit
import UniformTypeIdentifiers

/// Diagnostic view controller.
class DiagnosticViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    weak var coordinator: DiagnosticCoordinator?

    // MARK: - UI Elements

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = DiagnosticConstants.diagnosticTitle
        label.font = UIFont(name: "InriaSans-Bold", size: 40)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let instructionsLabel: UILabel = {
        let label = UILabel()
        label.text = DiagnosticConstants.instructionsText
        label.font = UIFont(name: "InriaSans-Regular", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let recordButton: UIButton = {
        let button = UIButton()
        button.setTitle(DiagnosticConstants.recordButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: "InriaSans-Bold", size: 16)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 34
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let galleryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(DiagnosticConstants.galleryButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: "InriaSans-Bold", size: 16)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.layer.cornerRadius = 34
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let instructionVideoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(DiagnosticConstants.instructionVideoButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: "InriaSans-Bold", size: 16)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.layer.cornerRadius = 34
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let gearImage = UIImage(systemName: "gear", withConfiguration: symbolConfig)?.withRenderingMode(.alwaysTemplate)
        button.setImage(gearImage, for: .normal)
        button.tintColor = UIColor.tabbarIcon
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        return button
    }()

    var viewModel: DiagnosticViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupUI()
        setupConstraints()
        setupBindings()

        recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        galleryButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)
        instructionVideoButton.addTarget(self, action: #selector(instructionVideoTapped), for: .touchUpInside)

        let settingsBarButton = UIBarButtonItem(customView: settingsButton)
        navigationItem.rightBarButtonItem = settingsBarButton
        setupSettingsButtonConstraints()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateLocalizedStrings),
            name: NSNotification.Name(LCLLanguageChangeNotification),
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Setup Methods

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(instructionsLabel)
        view.addSubview(instructionVideoButton)
        view.addSubview(recordButton)
        view.addSubview(galleryButton)
    }

    private func setupConstraints() {
        setupTitleLabelConstraints()
        setupInstructionsLabelConstraints()
        setupInstructionVideoButtonConstraints()
        setupRecordButtonConstraints()
        setupGalleryButtonConstraints()
    }

    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupInstructionsLabelConstraints() {
        NSLayoutConstraint.activate([
            instructionsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }

    private func setupInstructionVideoButtonConstraints() {
        NSLayoutConstraint.activate([
            instructionVideoButton.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 40),
            instructionVideoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            instructionVideoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            instructionVideoButton.heightAnchor.constraint(equalToConstant: 67)
        ])
    }

    private func setupRecordButtonConstraints() {
        NSLayoutConstraint.activate([
            recordButton.topAnchor.constraint(equalTo: instructionVideoButton.bottomAnchor, constant: 20),
            recordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            recordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            recordButton.heightAnchor.constraint(equalToConstant: 67)
        ])
    }

    private func setupGalleryButtonConstraints() {
        NSLayoutConstraint.activate([
            galleryButton.topAnchor.constraint(equalTo: recordButton.bottomAnchor, constant: 20),
            galleryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            galleryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            galleryButton.heightAnchor.constraint(equalToConstant: 67)
        ])
    }

    private func setupSettingsButtonConstraints() {
        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalToConstant: 30),
            settingsButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupBackgroundImage() {
        let backgroundImageView = UIImageView(image: UIImage(named: "background"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundImageView, at: 0)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupBindings() {
        viewModel.onUploadSuccess = { [weak self] response in
            guard let self = self else { return }
            let rawProb = response["probability"] as? Double ?? 0.0
            let diagnosis = response["diagnosis"] as? String ?? "Unknown"
            let percentage = CGFloat(rawProb * 100)
            self.dismiss(animated: true) {
                self.coordinator?.showResult(percentage: percentage, diagnosis: diagnosis)
            }
        }
        viewModel.onUploadFailure = { [weak self] error in
            self?.dismiss(animated: true) {
                self?.showAlert(title: "Upload Error", message: error.localizedDescription)
            }
        }
    }

    // MARK: - Actions

    @objc private func recordButtonTapped() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showAlert(
                title: DiagnosticConstants.cameraUnavailableTitle,
                message: DiagnosticConstants.cameraUnavailableMessage
            )
            return
        }
        guard let availableTypes = UIImagePickerController.availableMediaTypes(for: .camera),
              availableTypes.contains(UTType.movie.identifier)
        else {
            showAlert(
                title: DiagnosticConstants.videoRecordingUnavailableTitle,
                message: DiagnosticConstants.videoRecordingUnavailableMessage
            )
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.mediaTypes = [UTType.movie.identifier]
        imagePicker.videoQuality = .typeHigh
        present(imagePicker, animated: true)
    }

    @objc private func galleryButtonTapped() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            showAlert(
                title: DiagnosticConstants.galleryUnavailableTitle,
                message: DiagnosticConstants.galleryUnavailableMessage
            )
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [UTType.movie.identifier]
        present(imagePicker, animated: true)
    }

    @objc private func settingsTapped() {
        coordinator?.showSettings()
    }

    @objc private func instructionVideoTapped() {
        if let videoURL = Bundle.main.url(forResource: "instructionVideo", withExtension: "mp4") {
            let player = AVPlayer(url: videoURL)
            let playerVC = AVPlayerViewController()
            playerVC.player = player
            present(playerVC, animated: true) {
                player.play()
            }
        } else {
            showAlert(title: "Error", message: "Instruction video not found.")
        }
    }

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let videoURL = info[.mediaURL] as? URL {
            picker.dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                let loadingVC = LoadingViewController()
                loadingVC.modalPresentationStyle = .overFullScreen
                self.present(loadingVC, animated: true) {
                    self.viewModel.uploadVideo(videoURL: videoURL, serverURL: DiagnosticConstants.serverURL)
                }
            }
        } else {
            picker.dismiss(animated: true)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

    // MARK: - Localization Update

    @objc private func updateLocalizedStrings() {
        titleLabel.text = DiagnosticConstants.diagnosticTitle
        instructionsLabel.text = DiagnosticConstants.instructionsText
        recordButton.setTitle(DiagnosticConstants.recordButtonTitle, for: .normal)
        galleryButton.setTitle(DiagnosticConstants.galleryButtonTitle, for: .normal)
        instructionVideoButton.setTitle(DiagnosticConstants.instructionVideoButtonTitle, for: .normal)
    }
}
