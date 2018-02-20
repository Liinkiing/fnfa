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
    
    required init?(coder aDecoder: NSCoder) {
        programmeDataSource = ProgrammeDataSource(events: DataMapper.instance.events)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        programmeFlowLayout.spacingMode = .overlap(visibleOffset: 30)
        programmeCollectionView.register(UINib(nibName: String(describing: ProgrammeCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProgrammeCollectionViewCell.self))
        programmeCollectionView.dataSource = programmeDataSource
        programmeCollectionView.reloadData()
    }
    


}
