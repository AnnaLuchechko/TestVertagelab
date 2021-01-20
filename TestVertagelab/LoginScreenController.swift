//
//  LoginScreenController.swift
//  TestVertagelab
//
//  Created by Anna Luchechko on 20.01.2021.
//

import UIKit
import SnapKit

class LoginScreenController: UIViewController {

    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter email"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = 8.0
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = UIFont(name: "Noteworthy", size: 20.0)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter password"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = 8.0
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = UIFont(name: "Noteworthy", size: 20.0)
       return textField
   }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8.0
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Noteworthy", size: 20.0)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        runSnapKitAutoLayout()
    }
    
    private func setupView() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    }
    
    private func runSnapKitAutoLayout() {
        emailTextField.snp.makeConstraints { (make) in
            make.width.equalTo(280)
            make.height.equalTo(40)
            make.centerY.equalTo(view.snp.centerY).offset(-20.0)
            make.centerX.equalTo(view.snp.centerX)
        }
        passwordTextField.snp.makeConstraints { (make) in
            make.width.equalTo(280)
            make.height.equalTo(40)
            make.top.equalTo(emailTextField.snp.bottom).offset(20.0)
            make.centerX.equalTo(emailTextField.snp.centerX)
        }
        loginButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.top.equalTo(passwordTextField.snp.bottom).offset(50.0)
            make.centerX.equalTo(passwordTextField.snp.centerX)
        }
    }

}
