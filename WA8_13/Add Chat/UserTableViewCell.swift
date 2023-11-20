//
//  UserTableViewCell.swift
//  WA8_13
//
//  Created by Andrew Liu on 11/18/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var name: UILabel!
    var email: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupName()
        setupEmail()
        
        initConstraints()
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupName() {
        name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 20)
        name.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(name)
    }
    
    func setupEmail() {
        email = UILabel()
        email.font = UIFont.systemFont(ofSize: 15)
        email.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(email)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            name.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 5),
            name.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            name.heightAnchor.constraint(equalToConstant: 20),
            name.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            email.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            email.heightAnchor.constraint(equalToConstant: 15),
            email.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
