// CircularProgressView.swift
// Copyright © KadyrKZ. All rights reserved.

import UIKit

/// Представление для отображения кругового прогресс-бара.
/// Отрисовывает базовый круг (trackLayer) и прогресс (progressLayer).
class CircularProgressView: UIView {
    private var trackLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()

    var viewModel: CircularProgressViewModel? {
        didSet {
            updateView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }

    private func createCircularPath() {
        backgroundColor = .clear
        let centerPoint = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let radius = (frame.size.width - 20) / 2
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi

        let circularPath = UIBezierPath(
            arcCenter: centerPoint,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )

        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)

        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.green.cgColor
        progressLayer.lineWidth = 10
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }

    func updateView() {
        guard let vm = viewModel else { return }
        progressLayer.strokeEnd = vm.progress
        progressLayer.strokeColor = vm.strokeColor.cgColor
    }
}

extension CircularProgressView {
    var progress: CGFloat {
        get {
            viewModel?.progress ?? 0
        }
        set {
            if viewModel == nil {
                viewModel = CircularProgressViewModel()
            }
            viewModel?.progress = newValue
            updateView()
        }
    }
}
