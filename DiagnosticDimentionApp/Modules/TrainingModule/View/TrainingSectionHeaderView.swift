// TrainingSectionHeaderView.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

final class TrainingSectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "TrainingSectionHeaderView"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "InriaSans-Bold", size: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}
