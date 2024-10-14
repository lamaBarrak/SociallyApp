//
//  extensions.swift
//  SociallyApp
//
//  Created by macbook 2018 on 12/10/2024.
//

import UIKit



extension UIViewController {
    func showSpinner(message: String) {
        removeSpinner()
        let spinnerView = SpinnerView(message: message)
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinnerView)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinnerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            spinnerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Add tag to identify the spinner view later
        spinnerView.tag = 999
    }
    
    func removeSpinner() {
        if let spinnerView = view.viewWithTag(999) {
            spinnerView.removeFromSuperview()
        }
    }
    func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }

    }


@IBDesignable
class CustomView: UIView{

@IBInspectable var borderWidth: CGFloat = 0.0{

    didSet{

        self.layer.borderWidth = borderWidth
    }
}


@IBInspectable var borderColor: UIColor = UIColor.clear {

    didSet {

        self.layer.borderColor = borderColor.cgColor
    }
}
@IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

override func prepareForInterfaceBuilder() {

    super.prepareForInterfaceBuilder()
}

}

extension UIImage {
    func resizeTo(height: CGFloat? = nil, width: CGFloat? = nil) -> UIImage? {
        var newHeight:CGFloat = 100.0
        var newWidth:CGFloat = 100.0
        
        if let h = height {
            // resize using height
            let scale = h / self.size.height
            newHeight = h
            newWidth = self.size.width * scale
        } else if let w = width {
            // resize using width
            let scale = w / self.size.width
            newHeight = self.size.height * scale
            newWidth = w
        }
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
