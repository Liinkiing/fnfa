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

    let dateFormatter = DateFormatter()
    let identifier = "events\(UUID().uuidString)"
    
    var events: [Event]?
    var dayEventCount: Int?
    var dayNumber: Int?
    
    var day: Date?


    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd")
        eventsCollectionView.delegate = self as UICollectionViewDelegate
        eventsCollectionView.dataSource = self as UICollectionViewDataSource
        eventsCollectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
//        print("La collection view a comme reuse \(identifier)")
    }
    
    
    



    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("Pour le jour \(dayNumber), la CollectionView a retourné \(DataMapper.instance.events.findBy(day: dayNumber!)!.count)  items")
        dayNumber = Int(dateFormatter.string(from: day!))
        collectionView.tag = dayNumber!
        print("DAY \(collectionView.tag)")
        events = DataMapper.instance.events.findBy(day: collectionView.tag)
        return (events?.count)!
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print(identifier)
//        print(events)
        print(collectionView.tag)
        let cell = eventsCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! EventCollectionViewCell
//        print("La cellule pour le jour \(dayNumber) a comme reuse \(cell.reuseIdentifier!)")
//        print("IndexPath : \(indexPath)")
//        print("Pour le jour \(dayNumber), il y a \(events?.count) évènements")
//        print("IndexhPath : \(indexPath)")
//        print(events)
        print(dayNumber)
        let event = events?[indexPath.row]
//        cell.event = events?[indexPath.row]
        cell.eventImage.image = event?.getUIImage()
        cell.labelTitle.text = event?.name
        return cell
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
