    //
//  AgendaTableViewCell.swift
//  fnfa
//
//  Created by JBARA Omar on 15/02/2018.
//  Copyright © 2018 JBARA Omar. All rights reserved.
//

import UIKit

class AgendaTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var eventsCollectionView: UICollectionView!

    var day: Date?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventsCollectionView.delegate = self as UICollectionViewDelegate
        eventsCollectionView.dataSource = self as UICollectionViewDataSource
    }
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("d")
        let dayNumber = Int(dateFormatter.string(from: day!))
        print("Pour le jour \(dayNumber), la CollectionView a retourné \(DataMapper.instance.events.findBy(day: dayNumber!)!.count)  items")
        return DataMapper.instance.events.findBy(day: dayNumber!)!.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("d")
        let dayNumber = Int(dateFormatter.string(from: day!))
        let cell = eventsCollectionView.dequeueReusableCell(withReuseIdentifier: "events", for: indexPath) as! AgendaCollectionViewCell
        print("Pour le jour \(String(describing: dayNumber)), il y a \(DataMapper.instance.events.findBy(day: dayNumber!)?.count) évènements")
        print("Tu es actuellement à la row \(String(describing: indexPath.row))")
        print(DataMapper.instance.events.findBy(day: dayNumber!))
        cell.event = DataMapper.instance.events.findBy(day: dayNumber!)?[indexPath.row]
        cell.eventImage.image = cell.event?.getUIImage()
        
        return cell
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
