//
//  User.swift
//  WA8_13
//
//  Created by Andrew Liu on 11/18/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable{
    @DocumentID var id: String?
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
