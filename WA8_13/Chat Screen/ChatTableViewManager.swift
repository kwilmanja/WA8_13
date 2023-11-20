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
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewContactsID, for: indexPath) as! ContactsTableViewCell
        cell.labelName.text = messages[indexPath.row].text
        return cell
    }
    
}
