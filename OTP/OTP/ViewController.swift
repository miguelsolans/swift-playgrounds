//
//  ViewController.swift
//  OTP
//
//  Created by Miguel Solans on 29/05/2022.
//

import UIKit

class ViewController: BaseViewController {
    
    let credentialView = CredentialView();
    let headerView = TokenHeaderView();
    
    let stackView = UIStackView();
    let submitButton = UIButton();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setup();
    }
    
    func setup() {
        self.credentialView.delegate = self;
        self.submitButton.isUserInteractionEnabled = false;
    }
    
    override func style() {
        super.style();
        
        self.stackView.spacing = 2;
        self.stackView.axis = .vertical;
        self.stackView.distribution = .fillEqually
        
        
        // Submit Button
        self.submitButton.backgroundColor = UIColor(red: 0.60, green: 0.77,
                                                    blue: 0.94, alpha: 1.00);
        self.submitButton.setTitle("Submit", for: .normal);
        self.submitButton.setTitleColor(.white, for: .normal);
        self.submitButton.layer.cornerRadius = 7;
        self.submitButton.addTarget(self, action: #selector(submitButtonTapped),
                                    for: .touchUpInside)
    }
    
    override func layout() {
        
        super.layout();
        
        self.credentialView.translatesAutoresizingMaskIntoConstraints = false;
        self.headerView.translatesAutoresizingMaskIntoConstraints = false;
        self.submitButton.translatesAutoresizingMaskIntoConstraints = false;
        self.stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        
        self.view.addSubview(submitButton);
        self.view.addSubview(stackView);
        
        stackView.addArrangedSubview(self.headerView)
        stackView.addArrangedSubview(self.credentialView)
        
        NSLayoutConstraint.activate([
            submitButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -10),
            submitButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                  constant: 10),
            submitButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                   constant: -10),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.submitButton.topAnchor)
        ]);
    }
    
}

extension ViewController : CredentialViewDelegate {
    func didFinishTypingToken(_ credentialView: CredentialView) {
        print("ViewController - did Finish Typing Token");
        
        self.submitButton.isUserInteractionEnabled = true;
    }
}


// Actions
extension ViewController  {
    @objc func submitButtonTapped() {
        self.startLoading();
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.stopLoading()
        }
    }
}
