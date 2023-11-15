//
//  Validation.swift
//  WA6_Kwilman_0836
//
//  Created by Joph Kwilman on 10/26/23.
//

import Foundation
import UIKit


class Validation{
    
    static func checkName(self: UIViewController, name: String) -> Bool {
        if !name.isEmpty {
            return true
        } else{
            
            let alert = UIAlertController(
                title: "Invalid Name: ",
                message: "No name provided",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default))
            
            self.present(alert, animated: true)
            
            return false
        }
    }
    
    static func checkEmail(self: UIViewController, email: String) -> Bool {
        if !email.isEmpty, validEmail(email){
            return true
        } else{
            
            let alert = UIAlertController(
                title: "Invalid Email: ",
                message: "Please provide a valid email",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default))
            
            self.present(alert, animated: true)
            
            return false
        }
    }
    
    
    static func checkPassword(self: UIViewController, password: String) -> Bool{
        if !password.isEmpty{
            return true
        } else{
            
            let alert = UIAlertController(
                title: "Invalid Password: ",
                message: "Please provide a valid password",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default))
            
            self.present(alert, animated: true)
            
            return false
        }
    }
    
    
    //Found at: https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift/25471164#25471164
    
    static func validEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func checkPhoneNumber(self: UIViewController, phoneNumber: String) -> Bool {
        if !phoneNumber.isEmpty,
           let intPhoneNumber = Int(phoneNumber)
        {
            return true
        } else{
            
            let alert = UIAlertController(
                title: "Invalid Phone Number: ",
                message: "Please provide a valid phone number",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default))
            
            self.present(alert, animated: true)
            
            return false
        }
    }
}
