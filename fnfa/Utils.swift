//
// Created by Jbara Omar on 18/02/2018.
// Copyright (c) 2018 JBARA Omar. All rights reserved.
//

import Foundation

class Utils {

    static func getDayNumber(from: Date) -> Int
    {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("d")
        return Int(dateFormatter.string(from: from))!
    }

}
