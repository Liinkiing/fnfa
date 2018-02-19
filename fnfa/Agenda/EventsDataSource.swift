//
// Created by Jbara Omar on 19/02/2018.
// Copyright (c) 2018 JBARA Omar. All rights reserved.
//

import UIKit

class EventsDataSource: NSObject, UICollectionViewDataSource {

    var events: [Event]
    
    init(events: [Event]) {
        self.events = events
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(events.count == 0) {
            return 1
        }
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (events.count == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NoItemCollectionViewCell.self), for: indexPath)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EventCollectionViewCell.self), for: indexPath) as! EventCollectionViewCell
        cell.event = events[indexPath.item]
        return cell
    }
}
