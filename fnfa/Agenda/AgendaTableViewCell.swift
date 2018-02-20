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
    
    override func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .FAVORITE_ADD, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .FAVORITE_REMOVE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshFromAgenda), name: .AGENDA_FAVORITE_REMOVE, object: nil)
    }

    
    private func setup() {
        self.eventsDataSource = EventsDataSource(events: DataMapper.instance.getSavedFavorites().findBy(date: day!)!
            .sorted {
                return $0.id! < $1.id!
            })
        dateFormatter.setLocalizedDateFormatFromTemplate("d")
        eventsCollectionFlowLayout.spacingMode = .overlap(visibleOffset: 30)
        eventsCollectionView.dataSource = eventsDataSource
        eventsCollectionView.reloadData()
        eventsCollectionView.register(UINib(nibName: String(describing: NoItemCollectionViewCell.self), bundle: nil),
                                      forCellWithReuseIdentifier: String(describing: NoItemCollectionViewCell.self))
        eventsCollectionView.register(UINib(nibName: String(describing: EventCollectionViewCell.self), bundle: nil),
                forCellWithReuseIdentifier: String(describing: EventCollectionViewCell.self))
    }
    
    @objc
    private func refresh() {
        self.eventsDataSource?.events =  DataMapper.instance.getSavedFavorites()
            .findBy(date: day!)!
            .sorted {
                return $0.id! < $1.id!
            }
        eventsCollectionView.reloadData()
        eventsCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }
    
    @objc
    private func refreshFromAgenda() {
        self.eventsDataSource?.events =  DataMapper.instance.getSavedFavorites()
            .findBy(date: day!)!
            .sorted {
                return $0.id! < $1.id!
        }
        eventsCollectionView.reloadData()
    }
    

}
