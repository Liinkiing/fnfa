//
//  ProgrammeCollectionViewCell.swift
//  fnfa
//
//  Created by Jbara Omar on 20/02/2018.
//  Copyright © 2018 JBARA Omar. All rights reserved.
//

import UIKit

class LieuxTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelAdresse: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var busLabel: UILabel!
    @IBOutlet weak var stopsLabel: UILabel!
    

    var place : Place? {
        didSet {
            if let title = place?.name {
                titleLabel.text = title
            } else {
                titleLabel.removeFromSuperview()
            }
            if let adresse = place?.adresse {
                labelAdresse.text = adresse
            } else {
                labelAdresse.removeFromSuperview()
            }
            if let phone = place?.phone {
                labelPhone.text = phone
            } else {
                labelPhone.removeFromSuperview()
            }
            
            if let stops = place?.stops {
                stopsLabel.text = stops
            } else {
                stopsLabel.removeFromSuperview()
            }
            if let horaire = place?.schedule {
                scheduleLabel.text = horaire
            } else {
                scheduleLabel.removeFromSuperview()
            }
        }
    }
    
    override func awakeFromNib() {
//        buttonFav.setImage(#imageLiteral(resourceName: "like"), for: .normal)
//        buttonFav.setImage(#imageLiteral(resourceName: "like_fill"), for: .selected)
    }


}
