//
//  MainScreenView.swift
//  App10
//
//  Created by Sakib Miazi on 5/25/23.
//

import UIKit

class MainScreenView: UIView {
    //MARK: tableView for contacts...
    var tableViewContacts: UITableView!
    
    //MARK: bottom view for adding a Contact...
    var bottomAddView:UIView!
    var textFieldAddName:UITextField!
    var buttonAdd:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTableViewContacts()
        
        setupBottomAddView()
        setupTextFieldAddName()
        setupButtonAdd()
        
        initConstraints()
    }
    
    //MARK: the table view to show the list of contacts...
    func setupTableViewContacts(){
        tableViewContacts = UITableView()
        tableViewContacts.register(ContactsTableViewCell.self, forCellReuseIdentifier: "names")
        tableViewContacts.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewContacts)
    }
    
    //MARK: the bottom add contact view....
    func setupBottomAddView(){
        bottomAddView = UIView()
        bottomAddView.backgroundColor = .white
        bottomAddView.layer.cornerRadius = 6
        bottomAddView.layer.shadowColor = UIColor.lightGray.cgColor
        bottomAddView.layer.shadowOffset = .zero
        bottomAddView.layer.shadowRadius = 4.0
        bottomAddView.layer.shadowOpacity = 0.7
        bottomAddView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomAddView)
    }
    
    func setupTextFieldAddName(){
        textFieldAddName = UITextField()
        textFieldAddName.placeholder = "note..."
        textFieldAddName.borderStyle = .roundedRect
        textFieldAddName.translatesAutoresizingMaskIntoConstraints = false
        bottomAddView.addSubview(textFieldAddName)
    }
    
    func setupButtonAdd(){
        buttonAdd = UIButton(type: .system)
        buttonAdd.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonAdd.setTitle("Add Note", for: .normal)
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        bottomAddView.addSubview(buttonAdd)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            //bottom add view...
            bottomAddView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -8),
            bottomAddView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bottomAddView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            buttonAdd.bottomAnchor.constraint(equalTo: bottomAddView.bottomAnchor, constant: -8),
            buttonAdd.leadingAnchor.constraint(equalTo: bottomAddView.leadingAnchor, constant: 4),
            buttonAdd.trailingAnchor.constraint(equalTo: bottomAddView.trailingAnchor, constant: -4),
            
            textFieldAddName.bottomAnchor.constraint(equalTo: buttonAdd.topAnchor, constant: -8),
            textFieldAddName.leadingAnchor.constraint(equalTo: buttonAdd.leadingAnchor, constant: 4),
            textFieldAddName.trailingAnchor.constraint(equalTo: buttonAdd.trailingAnchor, constant: -4),
            
            bottomAddView.topAnchor.constraint(equalTo: textFieldAddName.topAnchor, constant: -8),
            //...
            
            tableViewContacts.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            tableViewContacts.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewContacts.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewContacts.bottomAnchor.constraint(equalTo: bottomAddView.topAnchor, constant: -8),
        ])
    }
    
    
    //MARK: initializing constraints...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
