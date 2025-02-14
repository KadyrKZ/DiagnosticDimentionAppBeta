//
//  SettingsViewController.swift
//  DiagnosticDimentionApp
//
//  Created by Kadyr Maratuly on 13.02.2025.
//

import UIKit

protocol SettingsCoordinatorProtocol: AnyObject {
    func didFinishSettings()
}

final class SettingsViewController: UIViewController {
    
    weak var coordinator: SettingsCoordinatorProtocol?
    
    // MARK: - UI Элементы
    
    private let languageSegmentedControl: UISegmentedControl = {
        // Названия сегментов: казахский, русский, английский
        let control = UISegmentedControl(items: ["Қазақ", "Рус", "Eng"])
        control.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "selectedLanguageIndex")
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let themeSegmentedControl: UISegmentedControl = {
        // Названия сегментов: Светлая, Тёмная
        let control = UISegmentedControl(items: ["Светлая", "Тёмная"])
        control.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "selectedThemeIndex")
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        languageSegmentedControl.addTarget(self, action: #selector(languageChanged), for: .valueChanged)
        themeSegmentedControl.addTarget(self, action: #selector(themeChanged), for: .valueChanged)
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
    }
    
    // MARK: - Настройка UI
    
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
    
    // MARK: - Действия
    
    @objc private func languageChanged() {
        let selectedIndex = languageSegmentedControl.selectedSegmentIndex
        UserDefaults.standard.set(selectedIndex, forKey: "selectedLanguageIndex")
        // Здесь можно обновить язык в приложении через LocalizationManager, если такой имеется.
    }
    
    @objc private func themeChanged() {
        let selectedIndex = themeSegmentedControl.selectedSegmentIndex
        UserDefaults.standard.set(selectedIndex, forKey: "selectedThemeIndex")
        // Применяем тему: 0 - светлая, 1 - тёмная
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

