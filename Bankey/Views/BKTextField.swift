//
//  BKTextField.swift
//  Bankey
//
//  Created by Venkatesham Boddula on 05/09/24.
//

import UIKit

class BKTextField: UITextField {
    
    init(hintText: String) {
        super.init(frame: .zero)
        placeholder = hintText
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
