//
//  BookAuthorExample.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/23/26.
//

import Foundation
import Core
import SwiftData

@Model
class Author {
    var name: String
    @Relationship(inverse: \Book.author) var books: [Book]?
    init(name: String) {
        self.name = name
    }
}

@Model
class Book {
    var title: String
    var author: Author?
    init(title: String, author: Author?) {
        self.title = title
    }
}

extension Book {
    static func predicate(author: Author) -> Predicate<Book> {
        
        let targetID = author.persistentModelID

//        // 2. Create the predicate using the ID
//        let predicate = #Predicate<MyModel> { model in
//            model.relationshipProperty?.persistentModelID == targetID
//        }
        
        // The macro automatically handles the comparison of model instances
        return #Predicate<Book> { book in
            book.author?.persistentModelID == targetID
        }
    }
}
