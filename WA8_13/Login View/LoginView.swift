//
//  LoginView.swift
//  WA7_Kwilman_0836
//
//  Created by Joph Kwilman on 11/3/23.
//

import UIKit

class LoginView: UIView {


    var contentWrapper:UIScrollView!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var labelEmail: UILabel!
    var labelPassword: UILabel!
    var buttonLogin: UIButton!
    var buttonRegister: UIButton!





    override init(frame: CGRect) {
        super.init(frame: frame)

        
        //MARK: set the background color...
        self.backgroundColor = .white

        //MARK: initializing the UI elements and constraints...

        setupContentWrapper()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupLabelEmail()
        setupLabelPassword()
        setupButtonLogin()
        setupButtonRegister()
        

        initConstraints()
    }

    //MARK: initializing the UI elements...

    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }

    func setupTextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "email@something.com"
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
    
        textFieldEmail.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldEmail.frame.height))
        textFieldEmail.leftViewMode = .always
        textFieldEmail.layer.borderWidth = 1.0
        textFieldEmail.layer.borderColor = UIColor.gray.cgColor
        textFieldEmail.layer.cornerRadius = 5.0
        contentWrapper.addSubview(textFieldEmail)
    }

    
    func setupTextFieldPassword(){
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "password"
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
    
        textFieldPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldPassword.frame.height))
        textFieldPassword.leftViewMode = .always
        textFieldPassword.layer.borderWidth = 1.0
        textFieldPassword.layer.borderColor = UIColor.gray.cgColor
        textFieldPassword.layer.cornerRadius = 5.0
        contentWrapper.addSubview(textFieldPassword)
    }
    
    

    func setupLabelEmail(){
        labelEmail = UILabel()
        labelEmail.text = "Email:"
        labelEmail.font = labelEmail.font.withSize(20)
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelEmail)
    }

    
    func setupLabelPassword(){
        labelPassword = UILabel()
        labelPassword.text = "Password:"
        labelPassword.font = labelPassword.font.withSize(20)
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelPassword)
    }
    
    func setupButtonLogin(){
        buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(buttonLogin)
    }


    func setupButtonRegister(){
        buttonRegister = UIButton(type: .system)
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(buttonRegister)
    }
    

    
    



    //MARK: initializing constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([

            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),

            labelEmail.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 16),
            labelEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textFieldEmail.topAnchor.constraint(equalTo: labelEmail.topAnchor, constant: 30),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            labelPassword.topAnchor.constraint(equalTo: textFieldEmail.topAnchor, constant: 30),
            labelPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textFieldPassword.topAnchor.constraint(equalTo: labelPassword.topAnchor, constant: 30),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textFieldPassword.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),

            buttonLogin.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            buttonLogin.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),


            buttonRegister.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 16),
            buttonRegister.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonRegister.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor)

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
