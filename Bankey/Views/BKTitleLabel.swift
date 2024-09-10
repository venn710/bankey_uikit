//
//  BKTitleLabel.swift
//  Bankey
//
//  Created by Venkatesham Boddula on 04/09/24.
//

import UIKit

class BKTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(title: String, color: UIColor) {
        self.init(frame: .zero)
        text = title
        textColor = color
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        font = .preferredFont(forTextStyle: .title1)

        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
