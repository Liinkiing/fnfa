//
//  Place.swift
//  json-parsing
//
//  Created by Jbara Omar on 14/12/2017.
//  Copyright © 2017 Brogrammers. All rights reserved.
//

import Foundation

class Place: NSObject, NSCoding, Decodable, IdProtocol, NameProtocol {
    
    var id: Int?
    var name: String?
    var seats: Int?

    static func ==(lhs: Place, rhs: Place) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id && lhs.seats == rhs.seats
    }

    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! Int?
        self.name = aDecoder.decodeObject(forKey: "name") as! String?
        self.seats = aDecoder.decodeObject(forKey: "seats") as! Int?
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(seats, forKey: "seats")
    }


}
