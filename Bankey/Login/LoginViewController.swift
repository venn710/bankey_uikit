//
//  ViewController.swift
//  Bankey
//
//  Created by Venkatesham Boddula on 04/09/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    let bkTitleLabel = BKTitleLabel(title: "Bankey", color: .black)
    let bkBodyLabel = BKBodyLabel(body: "Your premium source for all banking things!", color: .black)
    let bkLoginCredsView = BKLoginCredentialsView()
    let bkErrorLabel = BKBodyLabel(frame: .zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(bkTitleLabel)
        view.addSubview(bkBodyLabel)
        view.addSubview(bkLoginCredsView)
        view.addSubview(bkErrorLabel)
        
        bkErrorLabel.isHidden = true
        
        NSLayoutConstraint.activate([
            bkTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bkTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
            bkBodyLabel.topAnchor.constraint(equalTo: bkTitleLabel.bottomAnchor, constant: 20),
            bkBodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            bkBodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            bkLoginCredsView.topAnchor.constraint(equalTo: bkBodyLabel.bottomAnchor, constant: 20),
            bkLoginCredsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bkLoginCredsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bkLoginCredsView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            bkErrorLabel.topAnchor.constraint(equalTo: bkLoginCredsView.bottomAnchor, constant: 20),
            bkErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bkErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        
        bkLoginCredsView.closure = { [weak self] userName, password in
            guard let self = self else { return }
            guard let userName, let password else { return }
            validateCreds(userName: userName, password: password)
        }
    }
    
    private func validateCreds(userName: String, password: String) {
        if userName.isEmpty || password.isEmpty {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                bkErrorLabel.isHidden = false
                bkErrorLabel.text = "Username / password cannot be blank"
                bkErrorLabel.textColor = .systemRed
            }
        } else {
            bkLoginCredsView.buttonView.configuration?.showsActivityIndicator = true
            bkErrorLabel.isHidden = true
            bkErrorLabel.text = ""
        }
    }
}
