// NameEntryViewController.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// NameEntryConstants
enum NameEntryConstants {
    static let viewTitle = "Enter Patient Name"
    static let placeholder = "Enter your name"
    static let saveButtonTitle = "Save"
    static let keyboardShift: CGFloat = 70
}

protocol NameEntryCoordinatorProtocol: AnyObject {
    func didFinishNameEntry()
}

final class NameEntryViewController: UIViewController {
    private let viewModel: NameEntryViewModel
    private weak var coordinator: NameEntryCoordinatorProtocol?

    private lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = NameEntryConstants.placeholder
        tf.borderStyle = .roundedRect
        tf.returnKeyType = .done
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    init(viewModel: NameEntryViewModel, coordinator: NameEntryCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NameEntryConstants.viewTitle
        view.backgroundColor = .white
        setupUI()
        nameTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NameEntryConstants.saveButtonTitle,
            style: .done,
            target: self,
            action: #selector(didTapSave)
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setupUI() {
        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameTextField.widthAnchor.constraint(equalToConstant: 250),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func didTapSave() {
        let inputText = nameTextField.text ?? ""
        viewModel.saveRecord(with: inputText)
        coordinator?.didFinishNameEntry()
        dismiss(animated: true, completion: nil)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        if view.frame.origin.y == 0 {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y -= NameEntryConstants.keyboardShift
            }
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        if view.frame.origin.y != 0 {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = 0
            }
        }
    }
}

extension NameEntryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
