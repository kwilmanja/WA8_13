//
//  ProfileView.swift
//  WA7_Kwilman_0836
//
//  Created by Joph Kwilman on 11/5/23.
//

import UIKit

class ProfileView: UIView {


    var contentWrapper:UIScrollView!
    var labelName: UILabel!
    var labelEmail: UILabel!
//    var labelPassword: UILabel!
    var buttonLogout: UIButton!





    override init(frame: CGRect) {
        super.init(frame: frame)

        //MARK: set the background color...
        self.backgroundColor = .white

        //MARK: initializing the UI elements and constraints...

        setupContentWrapper()

        setupLabelName()
        setupLabelEmail()
//        setupLabelPassword()
        setupButtonLogout()


        initConstraints()
    }

    //MARK: initializing the UI elements...

    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }

    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 34)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelName)
    }


    func setupLabelEmail(){
        labelEmail = UILabel()
        labelEmail.font = labelEmail.font.withSize(20)
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelEmail)
    }

//    func setupLabelPassword(){
//        labelPassword = UILabel()
//        labelPassword.font = labelPassword.font.withSize(20)
//        labelPassword.translatesAutoresizingMaskIntoConstraints = false
//        contentWrapper.addSubview(labelPassword)
//    }

    func setupButtonLogout(){
        buttonLogout = UIButton(type: .system)
        buttonLogout.setTitle("Logout", for: .normal)
        buttonLogout.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(buttonLogout)
    }




    //MARK: initializing constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([

            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),

            labelName.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 16),
            labelName.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 16),
            labelEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

//            labelPassword.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 16),
//            labelPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            buttonLogout.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 16),
            buttonLogout.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonLogout.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor)

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
