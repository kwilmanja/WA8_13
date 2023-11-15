//
//  AuthStructs.swift
//  WA7_Kwilman_0836
//
//  Created by Joph Kwilman on 11/5/23.
//

import Foundation


struct UserRecord: Codable{
//    var _id: String
    var name: String
    var email: String
//    var __v: String

//    init(_id: String, name: String, email: String, __v: String) {

    init(name: String, email: String) {
        self.name = name
        self.email = email
//        self.__v = __v
//        self._id = _id
    }
    
    

}


struct AuthAttempt: Codable{
    var auth: Bool
    var token: String
    
    init(auth: Bool, token: String){
        self.auth = auth
        self.token = token
    }
    
    
}
