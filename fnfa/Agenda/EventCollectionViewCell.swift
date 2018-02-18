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
    @IBOutlet weak var labelTitle: UILabel!
    
    var event: Event? {
        didSet{
            print("tu viens de set l'event \(event!) pour la cellule \(tag)")
            eventImage.image = event?.getUIImage()
            labelTitle.text = event?.name
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
}
