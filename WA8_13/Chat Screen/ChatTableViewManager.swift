//
//  ChatTableViewManager.swift
//  WA8_13
//
//  Created by Joph Kwilman on 11/19/23.
//

import Foundation
import UIKit

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewContactsID, for: indexPath) as! ChatTableViewCell
        let m = messages[indexPath.row]
        
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        
        cell.labelText.text = m.text
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "y/MM/dd"
        let formattedDate = dateFormatter.string(from: m.time.dateValue())
        
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let formattedTime = dateFormatter.string(from: m.time.dateValue())

        cell.labelSender.text = "-\(m.sender) at \(formattedTime) on \(formattedDate)"
        
        if(m.sender == currentUser.displayName){
            cell.backgroundColor = UIColor.blue
        } else{
            cell.backgroundColor = UIColor.red
        }
        
        return cell
    }
    
}
