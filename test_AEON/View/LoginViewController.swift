//
//  LoginViewController.swift
//  test_AEON
//
//  Created by Andrey on 21.10.2021.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var service = Service()
    
    var label: UILabel!
    var loginTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        configureLabels()
        configureTextFields()
        configureTextFieldsDelegates()
        configureButtons()
        setLayoutConstraints()
    }
    
    func configureLabels() {
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Пожалуйста, введите логин и пароль"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        label.numberOfLines = 0
        view.addSubview(label)
    }
    
    func configureTextFields() {
        loginTextField = UITextField()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Login"
        loginTextField.textAlignment = .left
        loginTextField.font = UIFont.systemFont(ofSize: 25)
        loginTextField.borderStyle = .roundedRect
        loginTextField.keyboardType = UIKeyboardType.default
        loginTextField.layer.borderColor = UIColor.black.cgColor
        view.addSubview(loginTextField)
        
        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.textAlignment = .left
        passwordTextField.font = UIFont.systemFont(ofSize: 25)
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        view.addSubview(passwordTextField)
    }
    
    func configureTextFieldsDelegates() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func configureButtons() {
        loginButton = UIButton(type: .system)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Log In", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
    func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            loginTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            loginTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            passwordTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func loginTapped(_ sender: UIButton) {
        guard loginTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false else {
            print("Enter login and password")
            return
        }
        
        service.postReq(login: loginTextField.text!, password: passwordTextField.text!, completionHandler: { [self] token in
            DispatchQueue.main.async {
                if let _ = token {
                    
                    let paymentsViewController = UINavigationController(rootViewController: ViewController())
                    paymentsViewController.modalPresentationStyle = .fullScreen
                    
                    present(paymentsViewController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Ошибка", message: "Вы ввели не верный логин или пароль", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    present(alertController, animated: true)
                }
            }
        })
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
