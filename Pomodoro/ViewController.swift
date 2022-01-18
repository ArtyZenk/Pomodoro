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
        label.text = "Pomodoro"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var shapeView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ellipse")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = UIFont.boldSystemFont(ofSize: 70)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("START", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Timer
    private var timer =  Timer()
    
    private var workingTimer = 10
    private var relaxTimer = 5
    
    private enum WorkingMode {
        case work, relax
    }

    private var workingMode: WorkingMode = .work
    private let shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @objc func startButtonPressed() {
        switch workingMode {
        case .work:
            startButton.setTitle("RELAX", for: .normal)
            timerLabel.text = "10"
            
            basicAnimation(forTimer: workingTimer)
            animationCircular(color: UIColor.red.cgColor)

            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(workingTimerAction), userInfo: nil, repeats: true)
            relaxTimer = 5
            
            workingMode = .relax
        case .relax:
            startButton.setTitle("WORK AGAIN", for: .normal)
            timerLabel.text = "5"
            
            basicAnimation(forTimer: relaxTimer)
            animationCircular(color: UIColor.green.cgColor)

            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(relaxTimerAction), userInfo: nil, repeats: true)
            
            workingTimer = 10
            
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
        nameAppLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        shapeView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        shapeView.widthAnchor.constraint(equalToConstant: 300).isActive = true

        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
}
