// DiagnosticViewController.swift
// Copyright © KadyrKZ. All rights reserved.

import MobileCoreServices
import UIKit
import UniformTypeIdentifiers

/// Constants
enum Constants {
    static let diagnosticTitle = "Diagnostics"
    static let instructionsText = """
    Instructions:

    1. Tap "Record Video" to record.
    2. Follow recommendations (lighting, angle).
    3. Wait for diagnosis results.
    """
    static let recordButtonTitle = "Record Video"
    static let galleryButtonTitle = "Select Video from Gallery"
    static let settingsButtonTitle = "Settings"

    static let cameraUnavailableTitle = "Camera Unavailable"
    static let cameraUnavailableMessage = "This device does not support video recording."
    static let videoRecordingUnavailableTitle = "Video Recording Unavailable"
    static let videoRecordingUnavailableMessage = "Video recording is not available on this device."
    static let galleryUnavailableTitle = "Gallery Unavailable"
    static let galleryUnavailableMessage = "Access to the gallery is not available."

    static let serverURL = "https://my-flask-app-608127581259.us-central1.run.app/predict"
}

/// DiagnosticViewController
class DiagnosticViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    weak var coordinator: DiagnosticCoordinator?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.diagnosticTitle
        label.font = UIFont(name: "InriaSans-Bold", size: 40)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let instructionsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.instructionsText
        label.font = UIFont(name: "InriaSans-Regular", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let recordButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.recordButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: "InriaSans-Bold", size: 16)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 34
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let galleryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.galleryButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: "InriaSans-Bold", size: 16)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.layer.cornerRadius = 34
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var viewModel: DiagnosticViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupUI()
        setupBindings()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Constants.settingsButtonTitle,
            style: .plain,
            target: self,
            action: #selector(settingsTapped)
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !UserDefaults.standard.bool(forKey: "hasShownOnboarding") {
            coordinator?.showOnboarding()
        }
    }

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

    @objc private func recordButtonTapped() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showAlert(title: Constants.cameraUnavailableTitle, message: Constants.cameraUnavailableMessage)
            return
        }

        guard let availableTypes = UIImagePickerController.availableMediaTypes(for: .camera),
              availableTypes.contains(UTType.movie.identifier)
        else {
            showAlert(
                title: Constants.videoRecordingUnavailableTitle,
                message: Constants.videoRecordingUnavailableMessage
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
            showAlert(title: Constants.galleryUnavailableTitle, message: Constants.galleryUnavailableMessage)
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
                    self.viewModel.uploadVideo(videoURL: videoURL, serverURL: Constants.serverURL)
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
}
