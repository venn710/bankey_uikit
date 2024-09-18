//
//  OnBoardingViewController.swift
//  Bankey
//
//  Created by Venkatesham Boddula on 16/09/24.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    let imageResource: ImageResource
    let data: String
    init(imageResource: ImageResource, data: String) {
        self.imageResource = imageResource
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        configure()
        layoutSubviews()
    }
    
    var bkImageView = UIImageView()
    var bkDescription = BKBodyLabel()
    var stackView = UIStackView()
    
    
    private func configure() {
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(bkImageView)
        stackView.addArrangedSubview(bkDescription)
        
        bkDescription.text = data
        bkDescription.textColor = .label
        
        bkImageView.image = UIImage(resource: imageResource)
        bkImageView.contentMode = .scaleAspectFit
        bkImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutSubviews() {
        
        bkImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
