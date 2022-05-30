//
//  BaseViewController.swift
//  OTP
//
//  Created by Miguel Solans on 29/05/2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    let loadingView = UIView();

    override func viewDidLoad() {
        super.viewDidLoad();
        self.style();
        self.layout();
    }
    
    func style() {
        self.loadingView.backgroundColor = .white;
        self.loadingView.isHidden = true;
    }
    
    func layout() {
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(self.loadingView);
        NSLayoutConstraint.activate([
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]);
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.center.x, y: view.center.y),
                                      radius: CGFloat(60), startAngle: CGFloat(0),
                                      endAngle: CGFloat(Double.pi * 2), clockwise: true)
            
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(red: 0.60, green: 0.77, blue: 0.94, alpha: 1.00).cgColor;
        shapeLayer.lineWidth = 3.0
            
        self.loadingView.layer.addSublayer(shapeLayer)
        
    }
    
    func startLoading() {
        self.loadingView.isHidden = false;
        self.view.bringSubviewToFront(self.loadingView);
    }
    
    func stopLoading() {
        self.loadingView.isHidden = true;
        self.view.sendSubviewToBack(self.loadingView);
    }

}
