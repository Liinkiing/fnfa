//
// Created by Jbara Omar on 14/12/2017.
// Copyright (c) 2017 Brogrammers. All rights reserved.
//

import Foundation

class Category: NSObject, Decodable, IdProtocol, NameProtocol, NSCoding {
    var id: Int?
    var name: String?

    static func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }

    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! Int?
        self.name = aDecoder.decodeObject(forKey: "nale") as! String?
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
    }
}
