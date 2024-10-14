//
//  LoginVC.swift
//  SociallyApp
//
//  Created by macbook 2018 on 12/10/2024.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginbtn_click(_ sender: Any) {
        login()
    }
    
    func login(){
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        showSpinner(message: "login please wait ...")
        if email.isEmpty || password.isEmpty {
                   removeSpinner()
            showAlert(title: "Error", message: "Please enter both email and password.")
                   return
               }
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homevc = storyboard.instantiateViewController(withIdentifier: "homevc")
            self.present(homevc, animated: true)
        }
        
    }

}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            view.endEditing(true)
            login()
        }
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

