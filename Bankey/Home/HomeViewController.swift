//
//  HomeViewController.swift
//  Bankey
//
//  Created by Venkatesham Boddula on 18/09/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    let welcomeLabel = BKTitleLabel(title: "Hey, Welcome to Bankey!!", color: .cyan)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configure()
        // Do any additional setup after loading the view.
    }
    
    private func configure() {
        view.addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
