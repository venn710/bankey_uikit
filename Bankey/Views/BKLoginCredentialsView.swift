//
//  BKLoginCredentialsView.swift
//  Bankey
//
//  Created by Venkatesham Boddula on 05/09/24.
//
import UIKit

class BKLoginCredentialsView: UIView {
    
    let stackView = UIStackView()
    let buttonView = BKButtonView(backgroundColor: .systemBlue, foregroundColor: .white, text: "Sign In", systemImage: "person.fill")
    
    let userNameTextField = BKTextField(hintText: "Username")
    let passwordTextField = BKTextField(hintText: "Password")
    let dividerView = UIView()

    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getData() ->(userName: String?, password: String?) {
        (userNameTextField.text, passwordTextField.text)
    }
    
    var closure: ((String?, String?) -> Void)?
    
    private func configure() {
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.clipsToBounds = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)
        
        
        addSubview(stackView)
        addSubview(buttonView)
        
        buttonView.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        dividerView.backgroundColor = .secondarySystemFill
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            buttonView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            buttonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        stackView.layer.cornerRadius = 6
        stackView.backgroundColor = .secondarySystemBackground
        
        stackView.layoutMargins = .init(top: 6, left: 6, bottom: 6, right: 6)
        stackView.isLayoutMarginsRelativeArrangement = true

        translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    @objc func buttonTap() {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        closure?(userNameTextField.text, passwordTextField.text)
    }
}


extension BKLoginCredentialsView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
