// SettingsViewController.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// SettingsConstants
enum SettingsConstants {
    static let languageTitle = "Chose system language"
    static let themeTitle = "System theme"
    static let languageItems = ["Kazakh", "Russian", "English"]
    static let themeItems = ["Light", "Dark"]
    static let doneButtonTitle = "Done"
}

protocol SettingsCoordinatorProtocol: AnyObject {
    func didFinishSettings()
}

final class SettingsViewController: UIViewController {
    weak var coordinator: SettingsCoordinatorProtocol?

    // MARK: - UI Elements

    private let languageLabel: UILabel = {
        let label = UILabel()
        label.text = SettingsConstants.languageTitle
        label.font = UIFont(name: "InriaSans-Bold", size: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let languageSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: SettingsConstants.languageItems)
        control.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "selectedLanguageIndex")
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private let themeLabel: UILabel = {
        let label = UILabel()
        label.text = SettingsConstants.themeTitle
        label.font = UIFont(name: "InriaSans-Bold", size: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let themeSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: SettingsConstants.themeItems)
        control.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "selectedThemeIndex")
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle(SettingsConstants.doneButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: "InriaSans-Bold", size: 16)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 28
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .button
        setupUI()
        languageSegmentedControl.addTarget(self, action: #selector(languageChanged), for: .valueChanged)
        themeSegmentedControl.addTarget(self, action: #selector(themeChanged), for: .valueChanged)
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.addSubview(languageLabel)
        view.addSubview(languageSegmentedControl)
        view.addSubview(themeLabel)
        view.addSubview(themeSegmentedControl)
        view.addSubview(doneButton)

        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            languageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            languageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            languageSegmentedControl.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 20),
            languageSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            languageSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            themeLabel.topAnchor.constraint(equalTo: languageSegmentedControl.bottomAnchor, constant: 20),
            themeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            themeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            themeSegmentedControl.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 20),
            themeSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            themeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            doneButton.topAnchor.constraint(equalTo: themeSegmentedControl.bottomAnchor, constant: 40),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            doneButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    // MARK: - Actions

    @objc private func languageChanged() {
        let selectedIndex = languageSegmentedControl.selectedSegmentIndex
        UserDefaults.standard.set(selectedIndex, forKey: "selectedLanguageIndex")
        // Update language using a localization manager if needed.
    }

    @objc private func themeChanged() {
        let selectedIndex = themeSegmentedControl.selectedSegmentIndex
        UserDefaults.standard.set(selectedIndex, forKey: "selectedThemeIndex")

        if let windowScene = view.window?.windowScene, let window = windowScene.windows.first {
            window.overrideUserInterfaceStyle = (selectedIndex == 0) ? .light : .dark
        }
    }

    @objc private func doneTapped() {
        coordinator?.didFinishSettings()
        dismiss(animated: true, completion: nil)
    }
}
