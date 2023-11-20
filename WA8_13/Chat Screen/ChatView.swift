//
//  ChatView.swift
//  WA8_13
//
//  Created by Joph Kwilman on 11/19/23.
//

import UIKit

class ChatView: UIView {

    var tableViewChats: UITableView!
    
    var bottomAddView:UIView!
    var textFieldAddText:UITextField!
    var buttonSend:UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupTableViewChats()
        
        setupBottomAddView()
        setupTextFieldAddText()
        setupButtonSend()
        
        initConstraints()
    }
    
    
    func setupTableViewChats(){
        tableViewChats = UITableView()
        tableViewChats.register(ChatTableViewCell.self, forCellReuseIdentifier: Configs.tableViewContactsID)
        tableViewChats.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewChats)
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
    
    func setupTextFieldAddText(){
        textFieldAddText = UITextField()
        textFieldAddText.placeholder = "Message..."
        textFieldAddText.borderStyle = .roundedRect
        textFieldAddText.translatesAutoresizingMaskIntoConstraints = false
        bottomAddView.addSubview(textFieldAddText)
    }

    
    func setupButtonSend(){
        buttonSend = UIButton(type: .system)
        buttonSend.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonSend.setTitle("Send", for: .normal)
        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        bottomAddView.addSubview(buttonSend)
    }
    
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            bottomAddView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -8),
            bottomAddView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bottomAddView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            buttonSend.bottomAnchor.constraint(equalTo: bottomAddView.bottomAnchor, constant: -8),
            buttonSend.leadingAnchor.constraint(equalTo: bottomAddView.leadingAnchor, constant: 4),
            buttonSend.trailingAnchor.constraint(equalTo: bottomAddView.trailingAnchor, constant: -4),
            
            textFieldAddText.bottomAnchor.constraint(equalTo: buttonSend.topAnchor, constant: -8),
            textFieldAddText.leadingAnchor.constraint(equalTo: buttonSend.leadingAnchor, constant: 4),
            textFieldAddText.trailingAnchor.constraint(equalTo: buttonSend.trailingAnchor, constant: -4),
            
            bottomAddView.topAnchor.constraint(equalTo: textFieldAddText.topAnchor, constant: -8),

            tableViewChats.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewChats.bottomAnchor.constraint(equalTo: bottomAddView.topAnchor, constant: -8),
            tableViewChats.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewChats.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
