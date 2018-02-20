//
//  ProgrammeViewController.swift
//  fnfa
//
//  Created by JBARA Omar on 15/02/2018.
//  Copyright © 2018 JBARA Omar. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class ProgrammeViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var programmeCollectionView: UICollectionView!
    
    @IBOutlet weak var programmeFlowLayout: UPCarouselFlowLayout!
    
    var programmeDataSource: ProgrammeDataSource
    
    private var favorites: [Event]? = DataMapper.instance.getSavedFavorites()
    
    required init?(coder aDecoder: NSCoder) {
        programmeDataSource = ProgrammeDataSource(events: DataMapper.instance.events)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteAdded(notification:)), name: .FAVORITE_ADD, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteRemoved(notification:)), name: .FAVORITE_REMOVE, object: nil)
        programmeFlowLayout.spacingMode = .overlap(visibleOffset: 30)
        programmeCollectionView.register(UINib(nibName: String(describing: ProgrammeCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProgrammeCollectionViewCell.self))
        programmeCollectionView.dataSource = programmeDataSource
        programmeCollectionView.reloadData()
    }
    
    @objc
    private func favoriteAdded(notification: NSNotification) {
        favorites?.append(notification.object as! Event)
        DataMapper.instance.save(favorites!)
    }
    
    @objc
    private func favoriteRemoved(notification: NSNotification) {
        favorites = favorites?.filter { event in
            return event.id != (notification.object as! Event).id
         }
        DataMapper.instance.save(favorites!)
    }


}
