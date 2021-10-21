//
//  ViewController.swift
//  test_AEON
//
//  Created by Andrey on 20.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var mainLabel: UILabel!
    var loginButton: UIButton!
    var registerButton: UIButton!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        configureLabel()
        configureButtons()
        setLayoutConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configureLabel() {
        mainLabel = UILabel()
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.textAlignment = .center
        mainLabel.text = "Hello Dear Client! Please, Log In or Register"
        mainLabel.font = UIFont.systemFont(ofSize: 24)
        mainLabel.numberOfLines = 0
        view.addSubview(mainLabel)
    }
    
    func configureButtons() {
        loginButton = UIButton(type: .system)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        view.addSubview(loginButton)
        
        registerButton = UIButton(type: .system)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("REGISTER", for: .normal)
        registerButton.backgroundColor = .black
        registerButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        registerButton.layer.cornerRadius = 10
        registerButton.clipsToBounds = true
        view.addSubview(registerButton)
    }
    
    func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            mainLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            mainLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            loginButton.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 50),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            registerButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20)
        ])
    }

}

