//
//  RegisterViewController.swift
//  App12
//
//  Created by Sakib Miazi on 6/2/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    
    let childProgressView = ProgressSpinnerViewController()
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = registerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        registerView.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        title = "Register"
    }
    
    @objc func onRegisterTapped(){
        // validate password
        if (registerView.textFieldPassword.text != registerView.textFieldRepeatPassword.text) {
            showError("Passwords do not match.")
            return
        }
        
        if isValidEmail(registerView.textFieldEmail.text!) {
            // creating a new user on Firebase...
            registerNewAccount()
        } else {
            showError("The email is invalid!")
        }
    }
    
    func isValidEmail(_ email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: email)
    }
    
    func showError(_ msg: String) {
        let alert = UIAlertController(title: "Error!", message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
}
