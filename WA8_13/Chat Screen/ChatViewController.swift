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
    
    var keyboardHeight:CGFloat = 0
    
    override func loadView() {
        view = chatScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        attachHandler()
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
        
        // recognizing the taps on the app screen, not the keyboard
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        // move view up and down based on keyboard so you can see typed message
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        // remove observers
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
    // hide keyboard
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }

//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
////            print("Start 0: ", chatScreen.bottomAddView.frame.origin.y)
////            print(chatScreen.tableViewChats.frame.maxY)
////            if self.view.frame.origin.y == 0 {
////                self.view.frame.origin.y -= keyboardSize.height
////            }
////            print("Start 1: ", chatScreen.bottomAddView.frame.origin.y)
////            print(chatScreen.tableViewChats.frame.maxY)
//            
//            keyboardHeight = keyboardSize - chatScreen.safeAreaInsets.bottom
//            chatScreen.bottomAddView.frame.origin.y -= keyboardHeight
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
////        print("End 0: ", chatScreen.bottomAddView.frame.origin.y)
////        if self.view.frame.origin.y != 0 {
////            self.view.frame.origin.y = 0
////        }
////        print("End 1: ", chatScreen.bottomAddView.frame.origin.y)
//        
//        chatScreen.bottomAddView.frame.origin.y += keyboardHeight
//    }
    
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
