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
    var identifier = "events"
    var events: [Event]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.setLocalizedDateFormatFromTemplate("d")
        eventsCollectionView.delegate = self as UICollectionViewDelegate
        eventsCollectionView.dataSource = self as UICollectionViewDataSource
        eventsCollectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (events?.count)!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = eventsCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! EventCollectionViewCell
        cell.tag = Int(arc4random())
        cell.event = events?[indexPath.item]
        return cell
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
