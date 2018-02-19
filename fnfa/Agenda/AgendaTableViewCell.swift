//
//  AgendaTableViewCell.swift
//  fnfa
//
//  Created by JBARA Omar on 15/02/2018.
//  Copyright © 2018 JBARA Omar. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class AgendaTableViewCell: UITableViewCell {

    @IBOutlet weak var eventsCollectionView: UICollectionView!
    @IBOutlet weak var eventsCollectionFlowLayout: UPCarouselFlowLayout!
    
    var eventsDataSource: EventsDataSource?
    var day: Date? {
        didSet {
            setup()
        }
    }
    let dateFormatter = DateFormatter()

    private func setup() {
        self.eventsDataSource = EventsDataSource(events: DataMapper.instance.events.findBy(date: day!)!)
        dateFormatter.setLocalizedDateFormatFromTemplate("d")
        eventsCollectionFlowLayout.spacingMode = .overlap(visibleOffset: 30)
        eventsCollectionView.dataSource = eventsDataSource
        eventsCollectionView.reloadData()
        eventsCollectionView.register(UINib(nibName: String(describing: EventCollectionViewCell.self), bundle: nil),
                forCellWithReuseIdentifier: String(describing: EventCollectionViewCell.self))
    }

}
