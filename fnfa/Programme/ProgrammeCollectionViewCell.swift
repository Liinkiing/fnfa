//
//  ProgrammeCollectionViewCell.swift
//  fnfa
//
//  Created by Jbara Omar on 20/02/2018.
//  Copyright © 2018 JBARA Omar. All rights reserved.
//

import UIKit

class ProgrammeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPlace: UILabel!
    @IBOutlet weak var labelAudience: UILabel!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    var event: Event? {
        didSet {
            labelTitle.text = event?.name
            labelPlace.text = event?.places?.first?.name
            labelAudience.text = (event?.age != nil ? "A partir de \((event?.age!)!) ans" : "Pour tous public")
            eventImage.image = event?.getUIImage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buttonMoreTouch(_ sender: UIButton) {

    }
}
