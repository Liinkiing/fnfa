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
        print(DataMapper.instance.events.findBy(day: dayNumber!)!.count)
        return DataMapper.instance.events.findBy(day: dayNumber!)!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = eventsCollectionView.dequeueReusableCell(withReuseIdentifier: "events", for: indexPath) as! AgendaCollectionViewCell
        return cell
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
