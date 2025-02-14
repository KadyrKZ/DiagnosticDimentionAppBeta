//
//  CircularResultViewController.swift
//  AlzheimerDetectionApp
//
//  Created by [Ваше Имя] on 30.01.2025.
//

import UIKit

final class CircularResultViewController: UIViewController {

    // MARK: - Properties
    private let percentage: CGFloat
    private let diagnosis: String
    
    private let circularProgressView: CircularProgressView = {
        let cpv = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        cpv.translatesAutoresizingMaskIntoConstraints = false
        return cpv
    }()
    
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let probabilityDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let diagnosisLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Введите имя для сохранения результата"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Сохранить", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Назад", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Инициализация
    init(percentage: CGFloat, diagnosis: String) {
        self.percentage = percentage
        self.diagnosis = diagnosis
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        updateUI()
    }
    
    // MARK: - Настройка UI
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
            circularProgressView.widthAnchor.constraint(equalToConstant: 200),
            circularProgressView.heightAnchor.constraint(equalToConstant: 200),
            
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
            
            saveButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func updateUI() {
        let clampedPercentage = max(0, min(100, percentage))
        let normalized = clampedPercentage / 100.0
        
        // Обновляем круговой индикатор через вычисляемое свойство
        circularProgressView.progress = normalized
        percentageLabel.text = "\(Int(clampedPercentage))%"
        diagnosisLabel.text = "Диагноз: \(diagnosis)"
        probabilityDescriptionLabel.text = probabilityDescription(for: clampedPercentage)
    }
    
    private func probabilityDescription(for percentage: CGFloat) -> String {
        if percentage <= 30 {
            return "Очень низкая вероятность"
        } else if percentage <= 55 {
            return "Низкая вероятность"
        } else if percentage <= 80 {
            return "Хорошая вероятность"
        } else {
            return "Очень высокая вероятность"
        }
    }
    
    // MARK: - Действия
    @objc private func saveButtonTapped() {
        let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let finalName = name.isEmpty ? "Без имени" : name
        
        let record = DiagnosisRecord(
            patientName: finalName,
            date: Date(),
            probability: Double(percentage),
            diagnosis: diagnosis
        )
        DataManager.shared.addRecord(record)
        
        let alert = UIAlertController(title: "Успех",
                                      message: "Результат сохранен в истории",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
