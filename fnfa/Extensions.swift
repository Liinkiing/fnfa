//
// Created by Jbara Omar on 16/12/2017.
// Copyright (c) 2017 Brogrammers. All rights reserved.
//

import UIKit

enum SortDirection {
    case ascending, descending
}

enum EventSortProperty {
    case name, id, date
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

extension Formatter {
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "LLL"
        return formatter
    }()
    static let hour12: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "h"
        return formatter
    }()
    static let minute0x: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "mm"
        return formatter
    }()
    static let hour0x: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "HH"
        return formatter
    }()
    static let amPM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "a"
        return formatter
    }()
}
extension Date {
    var monthMedium: String  { return Formatter.monthMedium.string(from: self) }
    var hour12:  String      { return Formatter.hour12.string(from: self) }
    var minute0x: String     { return Formatter.minute0x.string(from: self) }
    var hour0x: String       { return Formatter.hour0x.string(from: self)}
    var amPM: String         { return Formatter.amPM.string(from: self) }
}

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

    func sorted(by: EventSortProperty, order: SortDirection = .ascending) -> [Event]? {
        return self.sorted {
            switch by {
            case .name:
                return order == .ascending ? $0.name! < $1.name! : $0.name! > $1.name!
            case .date:
                return order == .ascending ? $0.startingDate.getDate() < $1.startingDate.getDate() :
                    $0.startingDate.getDate() > $1.startingDate.getDate()
            case .id:
                return order == .ascending ? $0.id! < $1.id! : $0.id! > $1.id!
            }
        }
    }
    

    func findBy(locations: [String]) -> [Event]? {
        var result: [Event] = []
        locations.forEach { (location) in
            let results = self.filter({ (event) -> Bool in
                return event.places!.filter({ (place) -> Bool in
                    return place.name == location
                }).count > 0
            })
            result.append(contentsOf: results)
        }
        return Array(Set(result))
    }
    
    func latest(forDay: Date) -> Event {
        var latest = self.findBy(date: forDay)?.first
        self.forEach { (event) in
            if (latest?.endingDate.getDate())! < event.endingDate.getDate() {
                latest = event
            }
        }
        return latest!
    }
    
    func soonest(forDay: Date) -> Event? {
        var soonest = self.findBy(date: forDay)?.first
        if soonest != nil {
            self.findBy(date: forDay)?.forEach { (event) in
                if event.startingDate.getDate() < (soonest?.startingDate.getDate())! {
                    soonest = event
                }
            }
        }
        return soonest
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
            return interval.contains(event.startingDate.getDate())
        })
    }

    func between(startDate: Date, endDate: Date) -> [Event]? {
        return self.filter {
            return $0.startingDate.getDate() >= startDate && $0.startingDate.getDate() <= endDate
        }
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
            if strict {
                return element.name == name
            } else {
                return element.name!.lowercased().contains(name.lowercased())
            }
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

class DesignableImageView: UIImageView {
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.image = self.image?.withRenderingMode(.alwaysTemplate)
    }

    @IBInspectable
    var tint: UIColor? {
        didSet {
            if(tint != nil) {
                self.tintColor = tint
            }
        }
    }
}

@IBDesignable class TIFAttributedLabel: UILabel {
    
    @IBInspectable var fontSize: CGFloat = 14.0
    
    @IBInspectable var fontFamily: String = "Montserrat"
    
    override func awakeFromNib() {
        var attrString = NSMutableAttributedString(attributedString: self.attributedText!)
        attrString.addAttribute(NSAttributedStringKey.font, value: UIFont(name: self.fontFamily, size: self.fontSize)!, range: NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}

extension Notification.Name {
    static let FAVORITE_ADD = Notification.Name("FAVORITE_ADD")
    static let FAVORITE_REMOVE = Notification.Name("FAVORITE_REMOVE")
    static let AGENDA_FAVORITE_REMOVE =
            Notification.Name("AGENDA_FAVORITE_REMOVE")
    static let AGENDA_EVENT_TAPPED = Notification.Name("AGENDA_EVENT_TAPPED")
}

extension UICollectionViewCell {
    var collectionView: UICollectionView? {
        return next(UICollectionView.self)
    }

    var indexPath: IndexPath? {
        return collectionView?.indexPath(for: self)
    }

    var tableViewCell: UITableViewCell? {
        return next(UITableViewCell.self)
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return next(UITableView.self)
    }

    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
}

extension UIView {

    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next(type)
    }

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

