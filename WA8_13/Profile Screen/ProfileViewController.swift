//
//  ProfileViewController.swift
//  WA7_Kwilman_0836
//
//  Created by Joph Kwilman on 11/5/23.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {

    let profileScreen = ProfileView()
    
    var delegate:ViewController!
    var contact:OldNote!
    
    let notificationCenter = NotificationCenter.default

    override func loadView() {
        view = profileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        
        if let userToken = UserDefaults.standard.object(forKey: "userToken") as? String{
            getProfileDetails(userToken: userToken)
        }
        
        profileScreen.buttonLogout.addTarget(self, action: #selector(onButtonLogoutTapped), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
        hideKeyboardOnTapOutside()
    }
    
    func hideKeyboardOnTapOutside(){
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    
    func getProfileDetails(userToken: String){
        if let url = URL(string: APIConfigs.authURL+"me"){
            AF.request(url, method: .get, headers: ["x-access-token":userToken])
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
                                    let user = try decoder
                                        .decode(UserRecord.self, from: data)
                                    self.profileScreen.labelName.text = user.name
                                    self.profileScreen.labelEmail.text = user.email
                                    
                                }catch{

                                }
                                break
                    
                            case 400...499:
                            //MARK: the request was not valid 400-level...
                                print("400")
                                break
                    
                            default:
                            //MARK: probably a 500-level error...
                                print("Default")
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
        }
    }
    
    
    
    
    @objc func onButtonLogoutTapped(){
        UserDefaults.standard.removeObject(forKey: "userToken")
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
        
        
        
    }
    

}
