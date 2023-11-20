//
//  userChat.swift
//  WA8_13
//
//  Created by Joph Kwilman on 11/19/23.
//

import Foundation
import FirebaseFirestoreSwift

struct UserChat: Codable{
    @DocumentID var id: String?
    var chatId: String?
    var name: String
    
//    init(chatId: String) {
//        self.chatId = chatId
//    }
    
    init(id: String, chatId: String, name: String) {
        self.id = id
        self.chatId = chatId
        self.name = name
    }
    
    init(id: String, name: String){
        self.id = id
        self.name = name
    }

    
}
