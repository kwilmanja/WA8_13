//
//  ChatViewController.swift
//  WA8_13
//
//  Created by Joph Kwilman on 11/19/23.
//

import UIKit
import FirebaseFirestore

class ChatViewController: UIViewController {

    let chatScreen = ChatView()
        
    var contact: UserChat!
            
    let database = Firestore.firestore()
    
    var messages = [Message]()
    
    override func loadView() {
        view = chatScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.database.collection("chats")
            .document((contact.chatId))
            .collection("messages")
            .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                if let documents = querySnapshot?.documents{
                    self.messages.removeAll()
                    for document in documents{
                        do{
                            let contact  = try document.data(as: Message.self)
                            self.messages.append(contact)
                            print(contact.text)
                        }catch{
                            print(error)
                        }
                    }
                    self.messages.sort(by: {$0.id! < $1.id!})
                    self.chatScreen.tableViewContacts.reloadData()
                }
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = contact.id
        
        //MARK: patching table view delegate and data source...
        chatScreen.tableViewContacts.delegate = self
        chatScreen.tableViewContacts.dataSource = self
        
        //MARK: removing the separator line...
        chatScreen.tableViewContacts.separatorStyle = .none
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }

}
