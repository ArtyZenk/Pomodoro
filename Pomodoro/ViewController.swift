//
//  ViewController.swift
//  Pomodoro
//
//  Created by Artyom Guzenko on 18.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Elements
    private lazy var nameAppLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.nameAppLabel
        label.font = UIFont.boldSystemFont(ofSize: Metric.nameAppLabelFontSize)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var shapeView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Strings.nameImage)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.timerLabel
        label.font = UIFont.boldSystemFont(ofSize: Metric.timerLabelFontSize)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = Metric.startButtonCornerRadius
        button.setTitle(Strings.startButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Timer
    private var timer =  Timer()
    
    private var workingTimer = Metric.workingTimer
    private var relaxTimer = Metric.relaxTimer
    
    private enum WorkingMode {
        case work, relax
    }

    private var workingMode: WorkingMode = .work
    private let shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "\(workingTimer)"
        
        setupHierarch()
        setupLayout()
        setupView()
    }
    
    // MARK: - Actions
    @objc func startButtonPressed() {
        switch workingMode {
        case .work:
            startButton.setTitle("RELAX", for: .normal)
            timerLabel.text = String(Metric.workingTimer)
            
            basicAnimation(forTimer: workingTimer)
            animationCircular(color: UIColor.red.cgColor)

            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(workingTimerAction), userInfo: nil, repeats: true)
            relaxTimer = Metric.relaxTimer
            
            workingMode = .relax
        case .relax:
            startButton.setTitle("WORK AGAIN", for: .normal)
            timerLabel.text = String(Metric.relaxTimer)
            
            basicAnimation(forTimer: relaxTimer)
            animationCircular(color: UIColor.green.cgColor)

            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(relaxTimerAction), userInfo: nil, repeats: true)
            
            workingTimer = Metric.workingTimer
            
            workingMode = .work
        }
    }
    
    @objc func workingTimerAction() {
        workingTimer -= 1
        timerLabel.text = "\(workingTimer)"
        
        if workingTimer == 0 {
            animationCircular(color: UIColor.green.cgColor)
            timer.invalidate()
        }
    }
    
    @objc func relaxTimerAction() {
        relaxTimer -= 1
        timerLabel.text = "\(relaxTimer)"
        
        if relaxTimer == 0 {
            animationCircular(color: UIColor.red.cgColor)
            timer.invalidate()
        }
    }
    
    // MARK: - Animation
    private func animationCircular(color: CGColor?) {
        
        let center = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circularPath = UIBezierPath(arcCenter: center, radius: Metric.circularRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = Metric.lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = Metric.strokeEnd
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = color
        shapeView.layer.addSublayer(shapeLayer)
    }
    
    private func basicAnimation(forTimer type: Int) {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(type)
        basicAnimation.fillMode =  CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}

// MARK: - Settings
extension ViewController {
    
    private func setupHierarch() {
        
        view.addSubview(startButton)
        view.addSubview(nameAppLabel)
        view.addSubview(shapeView)
        view.addSubview(timerLabel)
        
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
    }
    
    private func setupLayout() {
        
        nameAppLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameAppLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Metric.nameAppLabelTopOfset).isActive = true
        
        shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        shapeView.heightAnchor.constraint(equalToConstant: Metric.shapeHeight).isActive = true
        shapeView.widthAnchor.constraint(equalToConstant: Metric.shapeWidth).isActive = true

        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Metric.startButtonBottomOfset).isActive = true
        startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Metric.startButtonMultiply).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: Metric.startButtonHeight).isActive = true
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
}

extension ViewController {
    enum Metric {
        static let circularRadius: CGFloat = 138
        static let lineWidth: CGFloat = 21
        static let strokeEnd: CGFloat = 1
        static let nameAppLabelFontSize: CGFloat = 25
        static let timerLabelFontSize: CGFloat = 70
        static let startButtonCornerRadius: CGFloat = 15
        
        static let workingTimer = 10
        static let relaxTimer = 5
        
        static let nameAppLabelTopOfset: CGFloat = 80
        static let shapeHeight: CGFloat = 300
        static let shapeWidth: CGFloat = 300
        
        static let startButtonBottomOfset: CGFloat = -50
        static let startButtonMultiply: CGFloat = 0.8
        static let startButtonHeight: CGFloat = 60        
    }
    
    enum Strings {
        static let nameAppLabel = "Pomodoro"
        static let nameImage = "ellipse"
        static let timerLabel = "10"
        static let startButtonTitle = "START"
    }
}
