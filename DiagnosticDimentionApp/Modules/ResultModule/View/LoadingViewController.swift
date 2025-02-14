//
//  LoadingViewController.swift
//  DiagnosticDimentionApp
//
//  Created by Kadyr Maratuly on 13.02.2025.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    private let messageLabel: UILabel = {
       let label = UILabel()
       label.text = "Пожалуйста, подождите.\nДиагностика занимает от 1 до 5 минут."
       label.font = UIFont.systemFont(ofSize: 18)
       label.numberOfLines = 0
       label.textAlignment = .center
       label.textColor = .black
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView(style: .large)
       indicator.translatesAutoresizingMaskIntoConstraints = false
       indicator.startAnimating()
       return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Полупрозрачный фон
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(activityIndicator)
        view.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            messageLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
