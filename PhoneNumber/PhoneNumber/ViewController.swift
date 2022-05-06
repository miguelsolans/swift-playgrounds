//
//  ViewController.swift
//  PhoneNumber
//
//  Created by Miguel Solans on 06/05/2022.
//

import UIKit


struct Country {
    let countryName: String
    let countryCode: String
    let phoneCode: String
}


class ViewController: UIViewController {
    
    // MARK: Data Objects
    let countryList = [
        Country(countryName: "Portugal", countryCode: "PT", phoneCode: "+351"),
        Country(countryName: "France", countryCode: "FR", phoneCode: "+33")
    ]

    // MARK: - User Interface Properties
    let phoneNumberTextField = UITextField();
    let countryTextField = UITextField();
    
    let countryPickerView = UIView();
    let tableView = UITableView();
    var countryPickerViewHeightConstraint: NSLayoutConstraint?;
    
    var backgroundView = UIView();
    var viewBackgroundConstraint: NSLayoutConstraint?;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setup();
        self.style();
    }

    func setup() {
        
        self.phoneNumberTextField.placeholder = "Phone Number";
        self.phoneNumberTextField.delegate = self;
        self.phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false;
        self.phoneNumberTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20));
        self.phoneNumberTextField.leftViewMode = .always;
        self.phoneNumberTextField.keyboardType = .numberPad;
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.openCountryPicker));
        doubleTap.numberOfTapsRequired = 2;
        self.countryTextField.addGestureRecognizer(doubleTap)
        
        self.countryTextField.delegate = self;
        self.countryTextField.placeholder = "+00"
        self.countryTextField.translatesAutoresizingMaskIntoConstraints = false;
        
        self.countryTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20));
        self.countryTextField.leftViewMode = .always;
        self.countryTextField.keyboardType = .phonePad;
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CountryCell")
        
        
        self.view.addSubview(self.countryPickerView);
        self.view.addSubview(self.phoneNumberTextField);
        self.view.addSubview(self.countryTextField);
        self.countryPickerView.addSubview(self.tableView);
        self.view.addSubview(self.backgroundView);
        
        
        self.view.bringSubviewToFront(self.countryPickerView);
        self.view.bringSubviewToFront(self.tableView);
    }
    
    func style() {
        
        self.styleTextField(self.phoneNumberTextField);
        self.styleTextField(self.countryTextField);
        
        self.countryPickerView.backgroundColor = .white;
        self.countryPickerView.layer.cornerRadius = 20;
        self.countryPickerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner];
        
        self.countryPickerView.translatesAutoresizingMaskIntoConstraints = false;
        self.countryPickerViewHeightConstraint = NSLayoutConstraint(item: self.countryPickerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0);
        self.viewBackgroundConstraint = NSLayoutConstraint(item: self.backgroundView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0);
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundView.backgroundColor = UIColor.backgroundColor;
        self.backgroundView.alpha = 0.5;
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false;
        self.tableView.backgroundColor = .clear;
        
        NSLayoutConstraint.activate([
            self.countryTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            self.countryTextField.widthAnchor.constraint(equalToConstant: 60),
            self.countryTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.countryTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.phoneNumberTextField.leftAnchor.constraint(equalTo: self.countryTextField.rightAnchor, constant: 15),
            self.phoneNumberTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            self.phoneNumberTextField.heightAnchor.constraint(equalToConstant: 45),
            self.phoneNumberTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            self.countryPickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.countryPickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.countryPickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.countryPickerViewHeightConstraint!,
            
            self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.backgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.viewBackgroundConstraint!,
            
            self.tableView.topAnchor.constraint(equalTo: self.countryPickerView.topAnchor, constant: 40),
            self.tableView.leftAnchor.constraint(equalTo: self.countryPickerView.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.countryPickerView.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.countryPickerView.bottomAnchor),
        ]);
    }
    
    // MARK: - TextField Style Helper Methods
    func styleTextField(_ textField: UITextField) {
        textField.layer.borderWidth = 2;
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.inactiveColor.cgColor;
    }
    
    
    
    func applyColorToTextField(_ textField: UITextField , color: UIColor) {
        let animation = CABasicAnimation(keyPath: "borderColor");
        animation.fromValue = textField.layer.borderColor;
        animation.toValue = color.cgColor;
        animation.duration = 0.5;
        textField.layer.add(animation, forKey: "borderColor");
        textField.layer.borderColor = color.cgColor;
    }
    
    // MARK: - Actions
    /// Open Country Picker When TextField is tapped twice
    @objc func openCountryPicker() {
        
        self.countryTextField.resignFirstResponder();
        
        self.countryPickerViewHeightConstraint?.constant = 250;
        self.viewBackgroundConstraint?.constant = self.view.frame.height;
        
        UIView.animate(withDuration: 0.3) {
            self.countryPickerView.layoutIfNeeded();
            self.countryPickerView.layoutSubviews()
        }
    }
    
    func closeCountryPicker() {
        self.countryPickerViewHeightConstraint?.constant = 0;
        self.viewBackgroundConstraint?.constant = 0;
        
        UIView.animate(withDuration: 0.3) {
            self.countryPickerView.layoutIfNeeded();
            self.countryPickerView.layoutSubviews()
        }
    }
}

// MARK: - TextField Delegate Methods
extension ViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.applyColorToTextField(textField, color: .activeColor);
        
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        
        self.applyColorToTextField(textField, color: .inactiveColor);
                
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.isEqual(self.countryTextField)) {
            var found = false;
            for country in self.countryList {
                if(country.phoneCode == textField.text) {
                    found = true;
                    break;
                }
            }
            
            if(!found) {
                self.applyColorToTextField(textField, color: .errorColor)
            }
        }
    }
}

// MARK: - UITableView Data Source Methods
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryList.count
    }
}

// MARK: - UITableView Delegate Methods
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath);
        
        
        cell.backgroundColor = .clear
        cell.textLabel?.text = self.countryList[ indexPath.row ].countryName;
        cell.detailTextLabel?.text = self.countryList[ indexPath.row ].phoneCode;
        
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        self.countryTextField.text = self.countryList[ indexPath.row ].phoneCode;
        
        self.textFieldDidEndEditing(self.countryTextField)
        
        self.closeCountryPicker();
    
    }
    
}

// MARK: - Themes
extension UIColor {
    
    static let activeColor = UIColor(red: 0.67, green: 0.84, blue: 0.93, alpha: 1.00)
    
    static let inactiveColor = UIColor(red: 0.85, green: 0.82, blue: 0.85, alpha: 1.00)
    
    static let errorColor = UIColor(red: 0.67, green: 0.20, blue: 0.16, alpha: 1.00);
    
    static let backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.00);
    
}

