// CircularResultViewController.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

final class CircularResultViewController: UIViewController {
    private let percentage: CGFloat
    private let diagnosis: String

    private let circularProgressView: CircularProgressView = {
        let cpv = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        cpv.translatesAutoresizingMaskIntoConstraints = false
        return cpv
    }()

    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = CircularResultConstants.defaultPercentageText
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let probabilityDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "InriaSans-Bold", size: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let diagnosisLabel: UILabel = {
        let label = UILabel()
        label.text = CircularResultConstants.diagnosisPrefix
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name to save result"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle(SettingsConstants.doneButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: "InriaSans-Bold", size: 16)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(percentage: CGFloat, diagnosis: String) {
        self.percentage = percentage
        self.diagnosis = diagnosis
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .button
        setupUI()
        updateUI()
    }

    private func setupUI() {
        view.addSubview(circularProgressView)
        view.addSubview(percentageLabel)
        view.addSubview(probabilityDescriptionLabel)
        view.addSubview(diagnosisLabel)
        view.addSubview(nameTextField)
        view.addSubview(saveButton)
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            circularProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circularProgressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            circularProgressView.widthAnchor.constraint(equalToConstant: 180),
            circularProgressView.heightAnchor.constraint(equalToConstant: 180),

            percentageLabel.centerXAnchor.constraint(equalTo: circularProgressView.centerXAnchor),
            percentageLabel.centerYAnchor.constraint(equalTo: circularProgressView.centerYAnchor),

            probabilityDescriptionLabel.topAnchor.constraint(equalTo: circularProgressView.bottomAnchor, constant: 20),
            probabilityDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            probabilityDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            diagnosisLabel.topAnchor.constraint(equalTo: probabilityDescriptionLabel.bottomAnchor, constant: 10),
            diagnosisLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            diagnosisLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            nameTextField.topAnchor.constraint(equalTo: diagnosisLabel.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),

            saveButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 14),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            saveButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    private func updateUI() {
        let clampedPercentage = max(0, min(100, percentage))
        let normalized = clampedPercentage / 100.0

        circularProgressView.progress = normalized
        percentageLabel.text = "\(Int(clampedPercentage))%"
        probabilityDescriptionLabel.text = probabilityDescription(for: clampedPercentage)
    }

    private func probabilityDescription(for percentage: CGFloat) -> String {
        if percentage <= 30 {
            return CircularResultConstants.veryLowProbability
        } else if percentage <= 55 {
            return CircularResultConstants.lowProbability
        } else if percentage <= 80 {
            return CircularResultConstants.goodProbability
        } else {
            return CircularResultConstants.veryHighProbability
        }
    }

    @objc private func saveButtonTapped() {
        let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let finalName = name.isEmpty ? CircularResultConstants.noName : name

        let record = DiagnosisRecord(
            patientName: finalName,
            date: Date(),
            probability: Double(percentage),
            diagnosis: diagnosis
        )
        DataManager.shared.addRecord(record)

        let alert = UIAlertController(
            title: CircularResultConstants.successTitle,
            message: CircularResultConstants.successMessage,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: CircularResultConstants.okTitle, style: .default))
        present(alert, animated: true)
    }

    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
