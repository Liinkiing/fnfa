//
//  LieuxDataSource.swift
//  fnfa
//
//  Created by CHERIF Yannis on 13/03/2018.
//  Copyright © 2018 Yannis Cherif. All rights reserved.
//

import UIKit

class LieuxDataSource: NSObject, UITableViewDataSource {
    
    var places: [Place]
    
    init(places: [Place]) {
        self.places = places
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(places.count == 0) {
            return 1
        }
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LieuxTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LieuxTableViewCell
        cell.place = self.places[indexPath.row]
        return cell
    }
    
    
    
    
    
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if(places.count == 0) {
//            return 1
//        }
//        return places.count
//    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if (places.count == 0) {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NoItemCollectionViewCell.self), for: indexPath)
//            return cell
//        }
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EventCollectionViewCell.self), for: indexPath) as! EventCollectionViewCell
//        cell.event = events[indexPath.item]
//        return cell
//    }
    
}
