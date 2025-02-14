//
//  NameEntryViewController.swift
//  DetectionDemetia
//
//  Created by [Ваше Имя] on 30.01.2025.
//

import UIKit

// Протокол, через который ViewController уведомляет координатора о завершении работы
protocol NameEntryCoordinatorProtocol: AnyObject {
    func didFinishNameEntry()
}

final class NameEntryViewController: UIViewController {
    
    // MARK: - Зависимости
    private let viewModel: NameEntryViewModel
    private weak var coordinator: NameEntryCoordinatorProtocol?
    
    // MARK: - UI Elements
    private lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Введите имя"
        tf.borderStyle = .roundedRect
        tf.returnKeyType = .done  // Тип клавиши Return
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // MARK: - Initialization
    init(viewModel: NameEntryViewModel, coordinator: NameEntryCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        // Используем стиль, позволяющий корректно изменять положение view
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Введите имя пациента"
        view.backgroundColor = .white
        setupUI()
        
        // Назначаем делегата текстового поля
        nameTextField.delegate = self
        
        // Добавляем жест для скрытия клавиатуры при нажатии вне текстового поля
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        // Добавляем кнопку "Сохранить" в правую часть навигационной панели
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .done,
            target: self,
            action: #selector(didTapSave)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Подписываемся на уведомления о появлении и скрытии клавиатуры
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Отписываемся от уведомлений
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(nameTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameTextField.widthAnchor.constraint(equalToConstant: 250),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Actions
    @objc private func didTapSave() {
        let inputText = nameTextField.text ?? ""
        viewModel.saveRecord(with: inputText)
        coordinator?.didFinishNameEntry()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Keyboard Notification Handlers
    @objc private func keyboardWillShow(notification: Notification) {
        // Поднимаем экран на 70 пунктов, если он ещё не сдвинут
        if view.frame.origin.y == 0 {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y -= 70
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        // Возвращаем экран в исходное положение, если он был сдвинут
        if view.frame.origin.y != 0 {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = 0
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension NameEntryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  // Скрываем клавиатуру
        return true
    }
}
