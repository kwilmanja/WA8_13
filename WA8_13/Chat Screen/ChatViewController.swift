//
//  ChatViewController.swift
//  WA8_13
//
//  Created by Joph Kwilman on 11/19/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import CryptoKit

class ChatViewController: UIViewController {

    let chatScreen = ChatView()
        
    var contact: UserChat!
    var currentUser: FirebaseAuth.User!
            
    let database = Firestore.firestore()
    
    var messages = [Message]()
    
    override func loadView() {
        view = chatScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        attachHandler()
        
    }
    
    func attachHandler(){
        if let chatId = contact.chatId{
            self.database.collection("chats")
                .document(chatId)
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
                        self.messages.sort(by: { $0.time.seconds < $1.time.seconds})
                        self.chatScreen.tableViewChats.reloadData()
                        self.scrollToBottom()
                    }
                })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = contact.name
        
        //MARK: patching table view delegate and data source...
        chatScreen.tableViewChats.delegate = self
        chatScreen.tableViewChats.dataSource = self
        
        //MARK: removing the separator line...
        chatScreen.tableViewChats.separatorStyle = .none
        
        chatScreen.buttonSend.addTarget(self, action: #selector(onButtonSendTapped), for: .touchUpInside)
        
    }
    
    @objc func onButtonSendTapped(){
        //do the validations...
        if let msgStr = chatScreen.textFieldAddText.text,
           msgStr.count != 0{
            
            let message = Message(sender: (self.currentUser?.displayName)!, text: msgStr)
            
            if contact.chatId == nil{
                sendThenLinkToUsers(message: message)
            } else{
                sendMessage(message: message)
            }
                    
            self.chatScreen.textFieldAddText.text = ""
        }
        else{
            print("Message line empty")
        }
    }
    
    
    func sendThenLinkToUsers(message: Message){
        
        print("creating chat")
        
        let emails = [currentUser.email!, contact.id!]
        let chatId = generateUUID(emails: emails)
        self.contact = UserChat(id: self.contact.id!, chatId: chatId, name:self.contact.name)
        
        
        if(self.sendMessage(message: message)){
            print("Success I think")
            
            let myContact = UserChat(id: self.currentUser.email!, chatId: chatId, name: self.currentUser.displayName!)
            do {
              try database.collection("users")
                    .document(self.contact.id!)
                    .collection("userChats")
                    .document(myContact.id!)
                    .setData(from: myContact)
            } catch let error {
              print("Error writing city to Firestore: \(error)")
            }
            
            
            
            do {
              try database.collection("users")
                    .document((self.currentUser?.email)!)
                    .collection("userChats")
                    .document(self.contact.id!)
                    .setData(from: self.contact)
            } catch let error {
              print("Error writing city to Firestore: \(error)")
            }
            
            attachHandler()
            
        }
        
        
        
        
    }
    
    func generateUUID(emails: [String]) -> String{
        let sortedEmails = emails.sorted()
        let joinedEmails = sortedEmails.joined()
        let joinedEmailsData = Data(joinedEmails.utf8)
        let hashed = Insecure.MD5.hash(data: joinedEmailsData)
        return hashed.compactMap{String(format: "%02x", $0)}.joined()
        
    }
    
    
    
    func sendMessage(message: Message) -> Bool{
        
        print("sending \(message.text)")
        
        do {
            try database.collection("chats")
                .document((contact.chatId!))
                .collection("messages")
                .document().setData(from: message)
            return true
        } catch let error {
            print("Error sending text: \(error)")
        }
        return false
        
    }
    
    
    func scrollToBottom() {
        let numberOfSections = chatScreen.tableViewChats.numberOfSections
        let numberOfRows = chatScreen.tableViewChats.numberOfRows(inSection: numberOfSections - 1)
        if numberOfRows > 0 {
            let indexPath = IndexPath(row: numberOfRows - 1,section: numberOfSections - 1)
            chatScreen.tableViewChats.scrollToRow(at: indexPath,at: .bottom, animated: true)
        }
    }

}
