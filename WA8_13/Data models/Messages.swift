//
//  Messages.swift
//  WA8_13
//
//  Created by Joph Kwilman on 11/19/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Codable{
    @DocumentID var id: String?
    var sender: String
    var text: String
    
    init(sender: String, text: String) {
        self.sender = sender
        self.text = text
    }
    
    init(id: String, sender: String, text: String) {
        self.id = id
        self.sender = sender
        self.text = text
    }
}
