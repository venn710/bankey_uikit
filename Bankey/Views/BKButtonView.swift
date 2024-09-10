//
//  BKButtonView.swift
//  Bankey
//
//  Created by Venkatesham Boddula on 05/09/24.
//

import UIKit

class BKButtonView: UIButton {
    
    init(backgroundColor: UIColor, foregroundColor: UIColor, text: String, systemImage: String? = nil) {
        super.init(frame: .zero)
        set(backgroundColor: backgroundColor, foregroundColor: foregroundColor, text: text, systemImage: systemImage)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func set(backgroundColor: UIColor, foregroundColor: UIColor, text: String, systemImage: String?)  {
        configuration = .filled()
        configuration?.baseBackgroundColor = backgroundColor
        configuration?.baseForegroundColor = foregroundColor
        configuration?.imagePadding = 4
        configuration?.imagePlacement = .leading
        
        configuration?.title = text
        
        if let systemImage {
            configuration?.image = UIImage(systemName: systemImage)
            configuration?.imagePadding = 4
            configuration?.imagePlacement = .leading
        }
        
        
        
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
