//
//  Place.swift
//  json-parsing
//
//  Created by Jbara Omar on 14/12/2017.
//  Copyright © 2017 Brogrammers. All rights reserved.
//

import Foundation
import UIKit

class Place : NSObject, NSCoding, Decodable, IdProtocol, NameProtocol {
    
    var id          : Int?
    var name        : String?
    var seats       : Int?
    var lat         : Double?
    var long        : Double?
    var adresse     : String?
    var phone       : String?
    var schedule    : String?
    var stops       : String?
    var bus         : Array<String>?

    static func ==(lhs: Place, rhs: Place) -> Bool {
        return lhs.name == rhs.name
            && lhs.id == rhs.id
            && lhs.seats == rhs.seats
            && lhs.lat == rhs.lat
            && lhs.long == rhs.long
            && lhs.adresse == rhs.adresse
            && lhs.phone == rhs.phone
            && lhs.schedule == rhs.schedule
            && lhs.stops == rhs.stops
    }

    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! Int?
        self.name = aDecoder.decodeObject(forKey: "name") as! String?
        self.lat = aDecoder.decodeObject(forKey: "lat") as! Double?
        self.long = aDecoder.decodeObject(forKey: "long") as! Double?
        self.seats = aDecoder.decodeObject(forKey: "seats") as! Int?
        self.adresse = aDecoder.decodeObject(forKey: "adresse") as! String?
        self.phone = aDecoder.decodeObject(forKey: "phone") as! String?
        self.schedule = aDecoder.decodeObject(forKey: "schedule") as! String?
        self.stops = aDecoder.decodeObject(forKey: "stops") as! String?
        self.bus = aDecoder.decodeObject(forKey: "bus") as! Array<String>?
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(long, forKey: "long")
        aCoder.encode(seats, forKey: "seats")
        aCoder.encode(adresse, forKey: "adresse")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(schedule, forKey: "schedule")
        aCoder.encode(stops, forKey: "stops")
        aCoder.encode(bus, forKey: "bus")
    }
}
