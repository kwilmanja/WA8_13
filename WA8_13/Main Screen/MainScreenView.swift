//
//  MainScreenView.swift
//  App12
//
//  Created by Sakib Miazi on 6/2/23.
//

import UIKit

class MainScreenView: UIView {
    var profilePic: UIImageView!
    var labelText: UILabel!
    var floatingButtonAddChat: UIButton!
    var tableViewContacts: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupProfilePic()
        setupLabelText()
        setupFloatingButtonAddChat()
        setupTableViewContacts()
        initConstraints()
    }
    
    //MARK: initializing the UI elements...
    func setupProfilePic(){
        profilePic = UIImageView()
        profilePic.image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal)
        profilePic.contentMode = .scaleToFill
        profilePic.clipsToBounds = true
        profilePic.layer.masksToBounds = true
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profilePic)
    }
    
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
    }
    
    func setupTableViewContacts(){
        tableViewContacts = UITableView()
        tableViewContacts.register(UserTableViewCell.self, forCellReuseIdentifier: Configs.tableViewContactsID)
        tableViewContacts.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewContacts)
    }
    
    func setupFloatingButtonAddChat(){
        floatingButtonAddChat = UIButton(type: .system)
        floatingButtonAddChat.setTitle("", for: .normal)
        floatingButtonAddChat.setImage(UIImage(systemName: "plus.message")?.withRenderingMode(.alwaysOriginal), for: .normal)
        floatingButtonAddChat.contentHorizontalAlignment = .fill
        floatingButtonAddChat.contentVerticalAlignment = .fill
        floatingButtonAddChat.imageView?.contentMode = .scaleAspectFit
        floatingButtonAddChat.layer.cornerRadius = 16
        floatingButtonAddChat.imageView?.layer.shadowOffset = .zero
        floatingButtonAddChat.imageView?.layer.shadowRadius = 0.8
        floatingButtonAddChat.imageView?.layer.shadowOpacity = 0.7
        floatingButtonAddChat.imageView?.clipsToBounds = true
        floatingButtonAddChat.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingButtonAddChat)
    }
    
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            profilePic.widthAnchor.constraint(equalToConstant: 32),
            profilePic.heightAnchor.constraint(equalToConstant: 32),
            profilePic.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            profilePic.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            labelText.topAnchor.constraint(equalTo: profilePic.topAnchor),
            labelText.bottomAnchor.constraint(equalTo: profilePic.bottomAnchor),
            labelText.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 8),
            
            tableViewContacts.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 8),
            tableViewContacts.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewContacts.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewContacts.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            floatingButtonAddChat.widthAnchor.constraint(equalToConstant: 48),
            floatingButtonAddChat.heightAnchor.constraint(equalToConstant: 48),
            floatingButtonAddChat.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            floatingButtonAddChat.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
  
