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


}

