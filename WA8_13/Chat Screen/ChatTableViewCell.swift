//
//  ChatTableViewCell.swift
//  WA8_13
//
//  Created by Joph Kwilman on 11/20/23.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var labelText: UILabel!
    var labelSender: UILabel!
//    var labelDate: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelText()
        setupLabelSender()
//        setupLabelDate()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = UIFont.boldSystemFont(ofSize: 20)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelText)
    }
    
    func setupLabelSender(){
        labelSender = UILabel()
        labelSender.font = UIFont.boldSystemFont(ofSize: 14)
        labelSender.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelSender)
    }
    
//    func setupLabelDate(){
//        labelDate = UILabel()
//        labelDate.font = UIFont.boldSystemFont(ofSize: 14)
//        labelDate.translatesAutoresizingMaskIntoConstraints = false
//        wrapperCellView.addSubview(labelDate)
//    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelText.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelText.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelText.heightAnchor.constraint(equalToConstant: 20),
            labelText.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            labelSender.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 2),
            labelSender.leadingAnchor.constraint(equalTo: labelText.leadingAnchor),
            labelSender.heightAnchor.constraint(equalToConstant: 16),
            labelSender.widthAnchor.constraint(lessThanOrEqualTo: labelText.widthAnchor),
//
//            labelDate.topAnchor.constraint(equalTo: labelSender.bottomAnchor, constant: 2),
//            labelDate.leadingAnchor.constraint(equalTo: labelSender.leadingAnchor),
//            labelDate.heightAnchor.constraint(equalToConstant: 16),
//            labelDate.widthAnchor.constraint(lessThanOrEqualTo: labelText.widthAnchor),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 50)
        ])
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
