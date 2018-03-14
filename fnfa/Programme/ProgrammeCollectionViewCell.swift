//
//  ProgrammeCollectionViewCell.swift
//  fnfa
//
//  Created by Jbara Omar on 20/02/2018.
//  Copyright © 2018 JBARA Omar. All rights reserved.
//

import UIKit
import SDWebImage

struct EventImageResponse: Codable {
    var name: String
    var id: Int?
    var image: String
    var absolutePath: String
}

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
            labelAudience.text = (event?.audience != nil ? "A partir de \((event?.audience!)!) ans" : "Pour tous public")
            if(event?.image == "random") {
                eventImage.image = event?.getPlaceholderImage()
            } else {
                eventImage.sd_setImage(with: URL(string: (event?.image)!), placeholderImage: event?.getPlaceholderImage())
            }
            buttonFav.isSelected = DataMapper.instance.isFavorited(event: event!)
        }
    }

    override func awakeFromNib() {
        buttonFav.setImage(#imageLiteral(resourceName:"like"), for: .normal)
        buttonFav.setImage(#imageLiteral(resourceName:"like_fill"), for: .selected)
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .FAVORITE_ADD, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .FAVORITE_REMOVE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .AGENDA_FAVORITE_REMOVE, object: nil)
    }

    @objc
    private func refresh() {
        buttonFav.isSelected = DataMapper.instance.isFavorited(event: event!)
    }


    @IBAction func buttonFavTap(_ sender: UIButton) {
        if (DataMapper.instance.isFavorited(event: event!)) {
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
