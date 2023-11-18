//
//  AddChatViewController.swift
//  WA8_13
//
//  Created by Andrew Liu on 11/18/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddChatViewController: UIViewController {
    
    var currentUser:FirebaseAuth.User?
    
    let addChatScreen = AddChatView()
    
    let database = Firestore.firestore()
    
    var usersList = [User]()
    
    override func loadView() {
        view = addChatScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Chat"
        
        getAllUsers()
        
        // patching table view delegate and data source
        addChatScreen.tableViewUsers.delegate = self
        addChatScreen.tableViewUsers.dataSource = self
        
        // removing the separator line
        addChatScreen.tableViewUsers.separatorStyle = .none
    }
    

    func getAllUsers() {
        self.database.collection("users").addSnapshotListener(includeMetadataChanges: false, listener: { querySnapshot, error in
            if let documents = querySnapshot?.documents {
                self.usersList.removeAll()
                for document in documents {
                    do {
                        let user = try document.data(as: User.self)
                        
                        if (user.id != self.currentUser?.email) {
                            self.usersList.append(user)
                        }
                    } catch {
                        print(error)
                    }
                }
                self.usersList.sort(by: {$0.name < $1.name})
                self.addChatScreen.tableViewUsers.reloadData()
            }
        })
    }
}

extension AddChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewUsersID, for: indexPath) as! UserTableViewCell
        cell.name.text = usersList[indexPath.row].name
        return cell
    }
}