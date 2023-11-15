//
//  RegisterView.swift
//  WA7_Kwilman_0836
//
//  Created by Joph Kwilman on 11/3/23.
//

import UIKit

class RegisterView: UIView {

    
    var contentWrapper:UIScrollView!
    
    
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelPassword: UILabel!
    var buttonRegister: UIButton!





    override init(frame: CGRect) {
        super.init(frame: frame)

        //MARK: set the background color...
        self.backgroundColor = .white

        //MARK: initializing the UI elements and constraints...

        setupContentWrapper()
        setupTextFieldName()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupLabelName()
        setupLabelEmail()
        setupLabelPassword()
        setupButtonRegister()
        

        initConstraints()
    }

    //MARK: initializing the UI elements...

    
    

    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    
    func setupTextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "John Doe"
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        textFieldName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldName.frame.height))
        textFieldName.leftViewMode = .always
        textFieldName.layer.borderWidth = 1.0
        textFieldName.layer.borderColor = UIColor.gray.cgColor
        textFieldName.layer.cornerRadius = 5.0
        contentWrapper.addSubview(textFieldName)
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
    
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.text = "Name:"
        labelName.font = labelName.font.withSize(20)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelName)
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

            labelName.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 16),
            labelName.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textFieldName.topAnchor.constraint(equalTo: labelName.topAnchor, constant: 30),
            textFieldName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textFieldName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            
            labelEmail.topAnchor.constraint(equalTo: textFieldName.topAnchor, constant: 30),
            labelEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textFieldEmail.topAnchor.constraint(equalTo: labelEmail.topAnchor, constant: 30),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            labelPassword.topAnchor.constraint(equalTo: textFieldEmail.topAnchor, constant: 30),
            labelPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textFieldPassword.topAnchor.constraint(equalTo: labelPassword.topAnchor, constant: 30),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textFieldPassword.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),

            buttonRegister.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            buttonRegister.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonRegister.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor)

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
