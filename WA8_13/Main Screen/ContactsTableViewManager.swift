//
//  ContactsTableViewManager.swift
//  App12
//
//  Created by Sakib Miazi on 6/2/23.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewContactsID, for: indexPath) as! ContactsTableViewCell
        cell.labelName.text = contactsList[indexPath.row].id
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("\(self.contactsList[indexPath.row].id!) -> \(self.contactsList[indexPath.row].chatId ?? "no chat ID")")
        let contact = self.contactsList[indexPath.row]
        let chatViewController = ChatViewController()
        chatViewController.contact = contact
        chatViewController.currentUser = self.currentUser
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
}
