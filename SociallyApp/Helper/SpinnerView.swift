//
//  SpinnerView.swift
//  SociallyApp
//
//  Created by macbook 2018 on 12/10/2024.
//

import UIKit

class SpinnerView: UIView {
    private var spinner: UIActivityIndicatorView!
    private var messageLabel: UILabel!

    init(message: String) {
        super.init(frame: CGRect.zero)
        setupView(message: message)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView(message: "")
    }
    
    private func setupView(message: String) {
        // Configure spinner
        spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = UIColor.white
        spinner.startAnimating()
        addSubview(spinner)
        
        // Configure label
        messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0 // Allow multiple lines
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
        
        // Configure background
        backgroundColor = UIColor(white: 0, alpha: 0.7)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        // Set up constraints
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            messageLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}


