//
//  ChatView.swift
//  WA8_13
//
//  Created by Joph Kwilman on 11/19/23.
//

import UIKit

class ChatView: UIView {

    var tableViewContacts: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupTableViewContacts()
        initConstraints()
    }
    
    
    func setupTableViewContacts(){
        tableViewContacts = UITableView()
        tableViewContacts.register(ContactsTableViewCell.self, forCellReuseIdentifier: Configs.tableViewContactsID)
        tableViewContacts.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewContacts)
    }
    
    
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            tableViewContacts.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewContacts.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewContacts.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewContacts.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
