//
// Created by Jbara Omar on 14/12/2017.
// Copyright (c) 2017 Brogrammers. All rights reserved.
//

import Foundation

class Date: NSObject, NSCoding, Decodable {
    var year: Int!
    var month: Int!
    var day: Int!
    var hour: Int!
    var minute: Int!

    func getDate() -> Foundation.Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-M-d H:m"
        formatter.timeZone = .current
        let string = "\(year!)-\(month!)-\(day!) \(hour!):\(minute!)"
        return formatter.date(from: string)!
    }

    required init?(coder aDecoder: NSCoder) {
        self.year = aDecoder.decodeObject(forKey: "year") as! Int!
        self.month = aDecoder.decodeObject(forKey: "month") as! Int!
        self.day = aDecoder.decodeObject(forKey: "day") as! Int!
        self.hour = aDecoder.decodeObject(forKey: "hour") as! Int!
        self.minute = aDecoder.decodeObject(forKey: "minute") as! Int!
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(year, forKey: "year")
        aCoder.encode(month, forKey: "month")
        aCoder.encode(day, forKey: "day")
        aCoder.encode(hour, forKey: "hour")
        aCoder.encode(minute, forKey: "minute")
    }

    func getDate(withFormat format: String, withLocale locale: Locale? = .current) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.setLocalizedDateFormatFromTemplate(format)
        return formatter.string(from: getDate())
    }
}
