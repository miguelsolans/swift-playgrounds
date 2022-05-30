//
//  TokenHeaderView.swift
//  OTP
//
//  Created by Miguel Solans on 29/05/2022.
//

import UIKit

class TokenHeaderView: UIView {
    
    let stackView = UIStackView();

    let imageView = UIImageView();
    let titleLabel = UILabel();
    let greetingLabel = UILabel();
    let messageLabel = UILabel();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.style()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }

}

extension TokenHeaderView {
    func style() {
        self.stackView.axis = .vertical;
        self.stackView.distribution = .fill;
        
        // Title Label: OTP Verification
        self.titleLabel.text = "OTP Verification"
        self.titleLabel.textAlignment = .center;
        
        self.greetingLabel.text = "Hello Miguel,"
        self.greetingLabel.textAlignment = .center;
        
        self.messageLabel.text = "Thank you for registering. Please type the OTP we've just sent to your mobile phone +351 96X XXX XXX";
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.lineBreakMode = .byWordWrapping;
        self.messageLabel.textAlignment = .center;
        
        self.imageView.image = UIImage(named: "otpAuthorization");
    }
    
    func layout() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.greetingLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.imageView.translatesAutoresizingMaskIntoConstraints = false;
        
        let imageContainerView = UIView();
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false;
        imageContainerView.addSubview(self.imageView);
        
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
            self.imageView.heightAnchor.constraint(equalTo: imageContainerView.heightAnchor),
            self.imageView.widthAnchor.constraint(equalTo: imageContainerView.widthAnchor)
        ]);
        
        let messagesContainerView = UIView();
        messagesContainerView.translatesAutoresizingMaskIntoConstraints = false;
        messagesContainerView.addSubview(self.greetingLabel);
        messagesContainerView.addSubview(self.messageLabel);
        
        NSLayoutConstraint.activate([
            self.greetingLabel.leadingAnchor.constraint(equalTo: messagesContainerView.leadingAnchor),
            self.greetingLabel.trailingAnchor.constraint(equalTo: messagesContainerView.trailingAnchor),
            self.greetingLabel.topAnchor.constraint(equalTo: messagesContainerView.topAnchor, constant: 5),
            
            self.messageLabel.leadingAnchor.constraint(equalTo: messagesContainerView.leadingAnchor),
            self.messageLabel.trailingAnchor.constraint(equalTo: messagesContainerView.trailingAnchor),
            self.messageLabel.topAnchor.constraint(equalTo: self.greetingLabel.bottomAnchor, constant: 15)
            
        ]);
        
        self.stackView.addArrangedSubview(imageContainerView);
        self.stackView.addArrangedSubview(messagesContainerView);
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]);
        
    }
}
