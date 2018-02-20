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
    
    @IBOutlet weak var buttonFav: UIButton!

    var event: Event? {
        didSet {
            labelTitle.text = event?.name
            labelPlace.text = event?.places?.first?.name
            labelAudience.text = (event?.age != nil ? "A partir de \((event?.age!)!) ans" : "Pour tous public")
            eventImage.image = event?.getUIImage()
            buttonFav.isSelected = isFavorited()
        }
    }
    
    override func awakeFromNib() {
        buttonFav.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        buttonFav.setImage(#imageLiteral(resourceName: "like_fill"), for: .selected)
    }
    

    @IBAction func buttonFavTap(_ sender: UIButton) {
        if(isFavorited()) {
            NotificationCenter.default.post(name: .FAVORITE_REMOVE, object: event)
            buttonFav.isSelected = false
        } else {
            NotificationCenter.default.post(name: .FAVORITE_ADD, object: event)
            buttonFav.isSelected = true
        }
    }

    @IBAction func buttonMoreTouch(_ sender: UIButton) {

    }

    
    private func isFavorited() -> Bool {
        if (DataMapper.instance.getSavedFavorites().count == 0) {
            return false
        }
        return DataMapper.instance.getSavedFavorites()
            .filter({ (event) -> Bool in
                event.id == self.event!.id
            }).count > 0
    }
}
