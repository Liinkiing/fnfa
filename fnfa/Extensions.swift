//
// Created by Jbara Omar on 16/12/2017.
// Copyright (c) 2017 Brogrammers. All rights reserved.
//

import UIKit

extension Array where Element == Event {
    func findBy(place: Place) -> [Event]? {
        return self.filter({ (event) -> Bool in
            return (event.places?.contains(place))!
        })
    }

    func findBy(category: Category) -> [Event]? {
        return self.filter({ (event) -> Bool in
            return event.category == category
        })
    }

    func findBy(day: Int) -> [Event]? {
        return self.filter({ (event) -> Bool in
            event.startingDate.day == day
        })
    }

    func findBy(date: Date) -> [Event]? {
        return self.filter({ (event) -> Bool in
            event.startingDate.day == Utils.getDayNumber(from: date)
        })
    }

    func filterBy(days: [Date]?) -> [Event]? {
        let daysNumber = days?.map {
            Utils.getDayNumber(from: $0)
        }
        return self.filter({ (event) -> Bool in
            return (daysNumber?.contains(event.startingDate.day))!
        })
    }
    
    func between(_ interval: DateInterval) -> [Event]? {
        return self.filter({ (event) -> Bool in
            interval.contains(event.startingDate.getDate())
        })
    }

}



extension Collection where Index == Int {
    func random() -> Iterator.Element {
        return self[Int(arc4random_uniform(UInt32(endIndex)))]
    }
}

extension Array where Element: NameProtocol {
    func findBy(name: String, useStrict strict: Bool = false) -> [NameProtocol]? {
        return self.filter({ element in
            if strict { return element.name == name }
            else { return element.name!.lowercased().contains(name.lowercased()) }
        })
    }
}

extension Array where Element: IdProtocol {
    func findBy(id: Int) -> IdProtocol? {
        return self.filter({ element in
            element.id == id
        }).first!
    }
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

@IBDesignable
class DesignableImageView: UIImageView {
}

extension Notification.Name {
    static let FAVORITE_ADD = Notification.Name("FAVORITE_ADD")
    static let FAVORITE_REMOVE = Notification.Name("FAVORITE_REMOVE")
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

