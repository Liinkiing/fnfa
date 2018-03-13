//
//  XIBEventCollectionViewCell.swift
//  fnfa
//
//  Created by Jbara Omar on 18/02/2018.
//  Copyright © 2018 JBARA Omar. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var labelExcerpt: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPlace: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    
    @IBAction func buttonDeleteFavTap(_ sender: UIButton) {
        DataMapper.instance.removeFromFavorites(event: event!, forceRefresh: false)
        collectionView?.performBatchUpdates({
            if((indexPath?.item)! > 0) {
                self.collectionView?.scrollToItem(
                    at: IndexPath(item: (self.indexPath?.item)! - 1, section: 0),
                    at: .centeredHorizontally,
                    animated: true)
            }
        }, completion: { (finished) in
            NotificationCenter.default.post(name: .AGENDA_FAVORITE_REMOVE, object: self.event!)
        })
        
    }
    
    var event: Event? {
        didSet{
            let df = DateFormatter()
            df.locale = Locale(identifier: "fr_FR")
            df.setLocalizedDateFormatFromTemplate("HH'h'mm")
            let start = df.string(from: (event?.startingDate.getDate())!)
            let end = df.string(from: (event?.endingDate.getDate())!)
            eventImage.image = event?.getPlaceholderImage()
            labelTitle.text = event?.name
            labelExcerpt.text = event?.excerpt
            labelPlace.text = event?.places?.first?.name
            labelDuration.text = "De \(start) à \(end)"
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
}
