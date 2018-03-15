//
// Created by Jbara Omar on 18/02/2018.
// Copyright (c) 2018 JBARA Omar. All rights reserved.
//

import Foundation
import UIKit

class Utils {

    static func getDayNumber(from: Date) -> Int
    {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("d")
        return Int(dateFormatter.string(from: from))!
    }
    
    static func scaleAnimation(forButton: UIButton) {
        forButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        forButton.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }

}
