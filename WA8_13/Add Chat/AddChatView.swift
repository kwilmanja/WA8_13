//
//  AddChatView.swift
//  WA8_13
//
//  Created by Andrew Liu on 11/18/23.
//

import UIKit

class AddChatView: UIView {
    var tableViewUsers: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupTableViewUsers()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableViewUsers() {
        tableViewUsers = UITableView()
        tableViewUsers.register(UserTableViewCell.self, forCellReuseIdentifier: Configs.tableViewUsersID)
        tableViewUsers.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewUsers)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewUsers.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewUsers.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewUsers.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewUsers.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
}
