//
//  Event.swift
//  json-parsing
//
//  Created by Jbara Omar on 14/12/2017.
//  Copyright © 2017 Brogrammers. All rights reserved.
//

import UIKit

class Event: NSObject, NSCoding, Decodable, IdProtocol, NameProtocol {
    var id: Int?
    var name: String?
    var excerpt: String?
    var image: String
    var audience: Int?
    var places: [Place]?
    var category: Category
    var startingDate: EventDate
    var endingDate: EventDate
    var producer: String?
    var director: String?
    var url: String?

    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }

    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! Int?
        self.name = aDecoder.decodeObject(forKey: "name") as! String?
        self.excerpt = aDecoder.decodeObject(forKey: "excerpt") as! String?
        self.image = aDecoder.decodeObject(forKey: "image") as! String
        self.audience = aDecoder.decodeObject(forKey: "audience") as! Int?
        self.places = aDecoder.decodeObject(forKey: "places") as! [Place]?
        self.category = aDecoder.decodeObject(forKey: "category") as! Category
        self.startingDate = aDecoder.decodeObject(forKey: "startingDate") as! EventDate
        self.endingDate = aDecoder.decodeObject(forKey: "endingDate") as! EventDate
        self.producer = aDecoder.decodeObject(forKey: "producer") as! String?
        self.director = aDecoder.decodeObject(forKey: "director") as! String?
        self.url = aDecoder.decodeObject(forKey: "url") as! String?
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(excerpt, forKey: "excerpt")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(audience, forKey: "audience")
        aCoder.encode(places, forKey: "places")
        aCoder.encode(category, forKey: "category")
        aCoder.encode(startingDate, forKey: "startingDate")
        aCoder.encode(endingDate, forKey: "endingDate")
        aCoder.encode(producer, forKey: "producer")
        aCoder.encode(director, forKey: "director")
        aCoder.encode(url, forKey: "url")
    }

    func getPlaceholderImage() -> UIImage {
            return #imageLiteral(resourceName: "motif-afca-14")
    }
    
    override var description: String {
        return "[\(id!)] - \(name!)"
    }
}
