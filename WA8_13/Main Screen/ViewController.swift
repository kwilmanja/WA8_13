//
//  ViewController.swift
//  App12
//
//  Created by Sakib Miazi on 6/1/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {

    let mainScreen = MainScreenView()
    
    // TODO change to current chats
//    var contactsList = [Contact]()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    var currentUser:FirebaseAuth.User?
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
                self.mainScreen.labelText.text = "Please sign in to see the notes!"
                self.mainScreen.floatingButtonAddChat.isEnabled = false
                self.mainScreen.floatingButtonAddChat.isHidden = true
                
                //MARK: Reset tableView...
//                self.contactsList.removeAll()
//                self.mainScreen.tableViewContacts.reloadData()
                
                //MARK: Sign in bar button...
                self.setupRightBarButton(isLoggedin: false)
                
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                self.mainScreen.floatingButtonAddChat.isEnabled = true
                self.mainScreen.floatingButtonAddChat.isHidden = false
                
                //MARK: Logout bar button...
                self.setupRightBarButton(isLoggedin: true)
                
                //MARK: Observe Firestore database to display the contacts list...
                self.database.collection("users")
                    .document((self.currentUser?.email)!)
                    .collection("contacts")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents{
//                            self.contactsList.removeAll()
                            for document in documents{
                                do{
                                    let contact  = try document.data(as: Contact.self)
//                                    self.contactsList.append(contact)
                                }catch{
                                    print(error)
                                }
                            }
//                            self.contactsList.sort(by: {$0.name < $1.name})
//                            self.mainScreen.tableViewContacts.reloadData()
                        }
                    })
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Chats"
        
//        //MARK: patching table view delegate and data source...
//        mainScreen.tableViewContacts.delegate = self
//        mainScreen.tableViewContacts.dataSource = self
//        
//        //MARK: removing the separator line...
//        mainScreen.tableViewContacts.separatorStyle = .none
        
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK: Put the floating button above all the views...
        view.bringSubviewToFront(mainScreen.floatingButtonAddChat)
        
        //MARK: tapping the floating add contact button...
        mainScreen.floatingButtonAddChat.addTarget(self, action: #selector(addChat), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    @objc func addChat(){
        let addChatController = AddChatViewController()
        addChatController.currentUser = self.currentUser
        navigationController?.pushViewController(addChatController, animated: true)
    }
}

