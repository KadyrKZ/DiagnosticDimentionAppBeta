// SettingsViewController.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// SettingsConstants
enum SettingsConstants {
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

    private let languageSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: SettingsConstants.languageItems)
        control.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "selectedLanguageIndex")
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private let themeSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: SettingsConstants.themeItems)
        control.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "selectedThemeIndex")
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(SettingsConstants.doneButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        languageSegmentedControl.addTarget(self, action: #selector(languageChanged), for: .valueChanged)
        themeSegmentedControl.addTarget(self, action: #selector(themeChanged), for: .valueChanged)
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.addSubview(languageSegmentedControl)
        view.addSubview(themeSegmentedControl)
        view.addSubview(doneButton)

        NSLayoutConstraint.activate([
            languageSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            languageSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            languageSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            themeSegmentedControl.topAnchor.constraint(equalTo: languageSegmentedControl.bottomAnchor, constant: 20),
            themeSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            themeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            doneButton.topAnchor.constraint(equalTo: themeSegmentedControl.bottomAnchor, constant: 40),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
        // Apply theme: 0 - Light, 1 - Dark.
        if selectedIndex == 0 {
            overrideUserInterfaceStyle = .light
        } else {
            overrideUserInterfaceStyle = .dark
        }
    }

    @objc private func doneTapped() {
        coordinator?.didFinishSettings()
        dismiss(animated: true, completion: nil)
    }
}
