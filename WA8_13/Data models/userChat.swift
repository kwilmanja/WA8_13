//
//  userChat.swift
//  WA8_13
//
//  Created by Joph Kwilman on 11/19/23.
//

import Foundation
import FirebaseFirestoreSwift

//struct UserChat: Codable{
//    var name: String?
//    var chatId: String
//
//
//    init(name: String, chatId: String) {
//        self.name = name
//        self.chatId = chatId
//    }
//}

struct UserChat: Codable{
    @DocumentID var id: String?
    var chatId: String
    
    init(chatId: String) {
        self.chatId = chatId
    }
    
    init(id: String, chatId: String) {
        self.id = id
        self.chatId = chatId
    }
}
