//
//  ViewController.swift
//  App10
//
//  Created by Sakib Miazi on 5/25/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let loginScreen = LoginView()
    
    override func loadView() {
        view = loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        if let userToken = UserDefaults.standard.object(forKey: "userToken") as? String,
           userToken != ""{
            print(userToken)
            let mainScreenController = MainScreenViewController()
            navigationController?.pushViewController(mainScreenController, animated: true)
        }
        
        title = "Login"
        navigationItem.hidesBackButton = true

        loginScreen.buttonRegister.addTarget(self, action: #selector(onButtonRegisterTapped), for: .touchUpInside)
        
        loginScreen.buttonLogin.addTarget(self, action: #selector(onButtonLoginTapped), for: .touchUpInside)
    }
    
    
    @objc func onButtonRegisterTapped(){
        let registerScreenController = RegisterViewController()
        navigationController?.pushViewController(registerScreenController, animated: true)
    }
    
    
    @objc func onButtonLoginTapped(){
        //Register:
        
        if let email = loginScreen.textFieldEmail.text,
           let password = loginScreen.textFieldPassword.text{
                //The String 'phoneText' is successfully converted to an Int...
            loginUser(password:password, email:email)
        }
        else{
            //alert....
        }
    }
    
    func clearInfo(){
        loginScreen.textFieldEmail.text = ""
        loginScreen.textFieldPassword.text = ""
    }
    
    
    func loginUser(password: String, email: String){
        if let url = URL(string: APIConfigs.authURL+"login"){
            
            AF.request(url, method:.post, parameters:
                        [
                            //MARK: we can unwrap them here since we made sure they are not null above...
                            "password": password,
                            "email": email,
                        ])
                .responseData(completionHandler: { response in
                    //MARK: retrieving the status code...
                    let status = response.response?.statusCode
                    
                    switch response.result{
                    case .success(let data):
                        //MARK: there was no network error...
                        
                        //MARK: status code is Optional, so unwrapping it...
                        if let uwStatusCode = status{
                            switch uwStatusCode{
                                case 200...299:
                                //MARK: the request was valid 200-level...
                                
                                let decoder = JSONDecoder()
                                    do{
                                        let auth =
                                            try decoder
                                            .decode(AuthAttempt.self, from: data)
                                        
                                        if auth.auth{
                                            UserDefaults.standard.set(auth.token, forKey:"userToken")
                                            print(auth.token)
                                        
                                            
                                            let mainScreenController = MainScreenViewController()
                                            self.navigationController?.pushViewController(mainScreenController, animated: true)
                                            
                                            self.clearInfo()
                                            
                                        } else{
                                            
                                            let alert = UIAlertController(
                                                title: "Login Failed",
                                                message: "Passord incorrect",
                                                preferredStyle: .alert)
                                            
                                            alert.addAction(UIAlertAction(
                                                title: "OK",
                                                style: .default))
                                            
                                            self.present(alert, animated: true)
                                                break
                                            
                                        }
                                        break
                                        
                                    }catch{
                                        print("JSON couldn't be decoded.")
                                    }
                                break
                        
                                case 401:
                                //MARK: the request was not valid 400-level...
                                
                                let alert = UIAlertController(
                                    title: "Login Failed",
                                    message: "Password incorrect",
                                    preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(
                                    title: "OK",
                                    style: .default))
                                
                                self.present(alert, animated: true)
                                break
                                
                            case 404:
                            //MARK: the request was not valid 400-level...
                            
                                let alert = UIAlertController(
                                    title: "Login Failed",
                                    message: "No user found",
                                    preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(
                                    title: "OK",
                                    style: .default))
                                
                                self.present(alert, animated: true)
                                break
                        
                                default:
                                //MARK: probably a 500-level error...
                                    print(data)
                                    break
                        
                            }
                        }
                        break
                        
                    case .failure(let error):
                        //MARK: there was a network error...
                        print(error)
                        break
                    }
                })
        }else{
            //alert that the URL is invalid...
        }
    }
    
    
    
}

