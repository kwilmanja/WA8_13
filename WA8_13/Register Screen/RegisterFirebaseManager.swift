//
//  RegisterFirebaseManager.swift
//  App12
//
//  Created by Sakib Miazi on 6/2/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension RegisterViewController{
    
    func registerNewAccount(){
        //MARK: display the progress indicator...
        showActivityIndicator()
        //MARK: create a Firebase user with email and password...
        if let name = registerView.textFieldName.text,
           let email = registerView.textFieldEmail.text,
           let password = registerView.textFieldPassword.text{
            //Validations....
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    //MARK: the user creation is successful...
                    self.setNameOfTheUserInFirebaseAuth(name: name, email: email)
                }else{
                    //MARK: there is a error creating the user...
                    print(error)
                    self.hideActivityIndicator()
                }
            })
        }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String, email:String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                let user = User(name: name)
                self.addUserToFirestore(user: user, email: email)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
                self.hideActivityIndicator()
            }
        })
    }
    
    func addUserToFirestore(user:User, email:String) {
        do {
            try self.database.collection("users").document(email.lowercased()).setData(from: user, completion: {(error) in
                if error == nil {
                    self.hideActivityIndicator()
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } catch {
            print("Error in adding new user to Firestore!")
        }
    }
}
