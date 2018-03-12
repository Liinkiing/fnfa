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
    @IBOutlet weak var labelExcerpt: UILabel!
    
    var event: Event? {
        didSet {
            labelTitle.text = event?.name
            labelPlace.text = event?.places?.first?.name
            labelAudience.text = (event?.age != nil ? "A partir de \((event?.age!)!) ans" : "Pour tous public")
            eventImage.image = event?.getUIImage()
            buttonFav.isSelected = DataMapper.instance.isFavorited(event: event!)
            labelExcerpt.text = event?.excerpt
        }
    }
    
    override func awakeFromNib() {
        buttonFav.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        buttonFav.setImage(#imageLiteral(resourceName: "like_fill"), for: .selected)
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .FAVORITE_ADD, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .FAVORITE_REMOVE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .AGENDA_FAVORITE_REMOVE, object: nil)
    }
    
    @objc
    private func refresh() {
        buttonFav.isSelected = DataMapper.instance.isFavorited(event: event!)
    }
    

    @IBAction func buttonFavTap(_ sender: UIButton) {
        if(DataMapper.instance.isFavorited(event: event!)) {
            buttonFav.isSelected = false
        DataMapper.instance.removeFromFavorites(event: event!)
        } else {
            buttonFav.isSelected = true
            DataMapper.instance.addToFavorites(event: event!)
        }
    }

    @IBAction func buttonMoreTouch(_ sender: UIButton) {

    }

}
