//
//  ProgrammeDataSource.swift
//  fnfa
//
//  Created by Jbara Omar on 20/02/2018.
//  Copyright © 2018 JBARA Omar. All rights reserved.
//

import UIKit

class ProgrammeDataSource : NSObject, UICollectionViewDataSource {
    
    var events: [Event]
    
    init(events: [Event]) {
        self.events = events
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgrammeCollectionViewCell.self), for: indexPath) as! ProgrammeCollectionViewCell
        cell.event = events[indexPath.item]
        return cell
    }
    
    
    
    
}
