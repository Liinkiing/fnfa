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
    var originals: [Event]
    var filters: [String] = []
    var timeline: TimeLineControl? = nil

    var filtersMap = [
        "movies": ["Séance spéciale", "Séance scolaire", "Long métrage et rencontres"],
        "activities": ["Atelier secret Fab", "Compétition et sélections"],
        "meetups": ["Salon des nouvelles écritures", "Volet professionnel"]
    ]
    
    init(events: [Event]) {
        self.originals = events
        self.events = self.originals
    }
    
    func filter() -> [Event] {
        self.events = self.originals
        if self.filters.count == 0 {
            return self.originals
        }
        return self.events.filter({ (event) -> Bool in
            var conditions: [Bool] = []
            for filter in self.filters {
                conditions.append((filtersMap[filter]?.contains(event.category.name!))! )
            }
            return conditions.contains(true)
        })
    }
    
    func getFirstEvent(ofDay: Int) -> Event {
        return (self.events.findBy(day: ofDay)?.first)!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgrammeCollectionViewCell.self), for: indexPath) as! ProgrammeCollectionViewCell
        cell.event = self.events[indexPath.item]
        let currentEvent = getFirstEvent(ofDay: (timeline?.timelineSteps)! + 3)
        let index = self.events.index(of: currentEvent)
//    
        return cell
    }

}
