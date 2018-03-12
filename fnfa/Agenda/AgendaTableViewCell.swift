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

    @IBOutlet weak var timeline: TimeLineControl!
    
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
        timeline.delegate = self
    }

    
    private func setup() {
        self.eventsDataSource = EventsDataSource(events: DataMapper.instance.getSavedFavorites().findBy(date: day!)!
            .sorted(by: .date)!)
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
            .sorted(by: .date)!
        eventsCollectionView.reloadData()
        eventsCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }
    
    @objc
    private func refreshFromAgenda() {
        self.eventsDataSource?.events =  DataMapper.instance.getSavedFavorites()
            .findBy(date: day!)!
            .sorted(by: .date)!
        eventsCollectionView.reloadData()
    }
    
}

extension AgendaTableViewCell : TimeLineControlDelegate {
    func userIsDragging(_ values: Array<CGFloat>) {
        
    }
    
    func userDidEndDrag(_ values: Array<CGFloat>) {
    
        
        let startDate = buildDateWith(hour: values.first!)
        let endDate = buildDateWith(hour: values.last!)
        
        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMM yyyy HH:mm:ss")

        print(dateFormatter.string(from: startDate!))
        print(dateFormatter.string(from: endDate!))


        self.eventsDataSource?.events =  DataMapper.instance.getSavedFavorites()
            .findBy(date: day!)!
            .between(startDate: startDate!, endDate: endDate!)!
            .sorted(by: .date)!
        eventsCollectionView.reloadData()
        eventsCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }

    private func buildDateWith(hour: CGFloat) -> Date? {
        let hours = hour / (100 / 24)
        let minutes = (hours.truncatingRemainder(dividingBy: 1) * 100) / (100 / 60)
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: day!)
        components.hour = Int(hours)
        components.minute = Int(minutes)
        components.second = 0
        return calendar.date(from: components)
    }
    
    func userAddedStep(_ value: Int) {
        
    }
    
    func userRemovedStep(_ value: Int) {
        
    }
    
    
}
