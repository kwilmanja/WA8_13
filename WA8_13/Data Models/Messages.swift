//
//  Messages.swift
//  WA8_13
//
//  Created by Joph Kwilman on 11/19/23.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Message: Codable{
    @DocumentID var id: String?
    var sender: String
    var text: String
    var time: Timestamp
    
    init(sender: String, text: String) {
        self.sender = sender
        self.text = text
        let currentDate = Date()
        self.time = Timestamp(date: currentDate)
    }
    
    init(id: String, sender: String, text: String) {
        self.id = id
        self.sender = sender
        self.text = text
        let currentDate = Date()
        self.time = Timestamp(date: currentDate)
    }
    
    
    enum CodingKeys: String, CodingKey {
        case sender
        case text
        case time
    }
    
}
