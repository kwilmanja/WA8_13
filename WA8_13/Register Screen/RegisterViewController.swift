//
//  RegisterViewController.swift
//  WA7_Kwilman_0836
//
//  Created by Joph Kwilman on 11/3/23.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    
    
    let registerScreen = RegisterView()
    
    override func loadView() {
        view = registerScreen
    }
    
    func clearInfo(){
        registerScreen.textFieldEmail.text = ""
        registerScreen.textFieldPassword.text = ""
        registerScreen.textFieldName.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Register"

        registerScreen.buttonRegister.addTarget(self, action: #selector(onButtonRegisterTapped), for: .touchUpInside)
        
    }
    
    @objc func onButtonRegisterTapped(){
        //Register:
        
        if let name = registerScreen.textFieldName.text,
           let email = registerScreen.textFieldEmail.text,
           let password = registerScreen.textFieldPassword.text{
            
            if  Validation.checkPassword(self: self, password: password),
                Validation.checkName(self: self, name: name),
                Validation.checkEmail(self: self, email: email){
                //The String 'phoneText' is successfully converted to an Int...
                registerUser(name:name, email:email, password:password)
            }
        }
        else{
            //alert....
        }
    }
    
    
    func registerUser(name: String, email: String, password:String){
        if let url = URL(string: APIConfigs.authURL+"register"){
            
            AF.request(url, method:.post, parameters:
                        [
                            //MARK: we can unwrap them here since we made sure they are not null above...
                            "name": name,
                            "email": email,
                            "password": password
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

                                        }
                                        break
                                        
                                    }catch{
                                        print("JSON couldn't be decoded.")
                                    }
                                break
                        
                                case 400...499:
                                //MARK: the request was not valid 400-level...
                                    print(data)
                                    break
                                
                            case 500:
                                let alert = UIAlertController(
                                    title: "Register Failed",
                                    message: "User Taken",
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
