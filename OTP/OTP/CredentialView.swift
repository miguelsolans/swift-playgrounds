//
//  CredentialView.swift
//  OTP
//
//  Created by Miguel Solans on 29/05/2022.
//

import UIKit

protocol CredentialViewDelegate: AnyObject {
    func didFinishTypingToken(_ credentialView: CredentialView);
}

class CredentialView: UIView {
    
    let stackView = UIStackView();
    
    let firstTextField = UITextField();
    let secondTextField = UITextField();
    let thirdTextField = UITextField();
    let fourthTextField = UITextField();
    
    weak var delegate: CredentialViewDelegate?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setup();
        self.style();
        self.layout();
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}


extension CredentialView {
    
    @objc func setup() {
        self.firstTextField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged);
        self.secondTextField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged);
        self.thirdTextField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged);
        self.fourthTextField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged);
        
    }
    
    func style() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .horizontal;
        stackView.spacing = 10;
        stackView.distribution = .fillEqually
        self.styleTextField(self.firstTextField)
        self.styleTextField(self.secondTextField)
        self.styleTextField(self.thirdTextField)
        self.styleTextField(self.fourthTextField)
        
        
    }
    
    func layout() {
        
        self.addSubview(stackView);
        
        stackView.addArrangedSubview(firstTextField);
        stackView.addArrangedSubview(secondTextField);
        stackView.addArrangedSubview(thirdTextField);
        stackView.addArrangedSubview(fourthTextField);
        
        
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 60),
            stackView.widthAnchor.constraint(equalToConstant: 250)
        ]);
    }
    
    
    func styleTextField(_ textField: UITextField) {
        textField.textAlignment = .center;
        textField.layer.borderWidth = 2;
        textField.layer.borderColor = UIColor.gray.cgColor;
        textField.layer.masksToBounds = true;
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        textField.delegate = self;
    }
    
    func textFieldFilled(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.60, green: 0.77, blue: 0.94, alpha: 1.00).cgColor
    }
    
    func textFieldEmpty(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.gray.cgColor;
    }
    
    func invalidToken() {
        self.firstTextField.layer.borderColor = UIColor.red.cgColor;
        self.secondTextField.layer.borderColor = UIColor.red.cgColor;
        self.thirdTextField.layer.borderColor = UIColor.red.cgColor;
        self.fourthTextField.layer.borderColor = UIColor.red.cgColor;
        
    }
}

extension CredentialView : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        let currentStr = (textField.text ?? "") as NSString
        let newStr = currentStr.replacingCharacters(in: range, with: string)
        

        return newStr.count <= maxLength;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("CredentialView - TextField did End Editing");
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        print("CredentialView - TextField did Begin Editing");
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        
        if(textField.text?.count == 0) {
            self.textFieldEmpty(textField);
        } else {
            self.textFieldFilled(textField)
        }
        textField.resignFirstResponder();
        if(textField.isEqual(self.firstTextField)) {
            self.secondTextField.becomeFirstResponder();
        } else if(textField.isEqual(self.secondTextField)) {
            self.thirdTextField.becomeFirstResponder();
        } else if(textField.isEqual(self.thirdTextField)) {
            self.fourthTextField.becomeFirstResponder();
        } else if(textField.isEqual(self.fourthTextField)) {
            self.delegate?.didFinishTypingToken(self)
        }
    }
}


/*!
 * Extensions with Actions
 */
extension CredentialView {
    public func clearToken() {
        self.firstTextField.text = "";
        self.secondTextField.text = "";
        self.thirdTextField.text = "";
        self.fourthTextField.text = "";
        
        self.textFieldEmpty(self.firstTextField)
        self.textFieldEmpty(self.secondTextField)
        self.textFieldEmpty(self.thirdTextField)
        self.textFieldEmpty(self.fourthTextField)
    }
}

