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
                titleLabel.isHidden = false
                titleLabel.text = title
            } else {
                titleLabel.isHidden = true
            }
            if let adresse = place?.adresse {
                labelAdresse.isHidden = false
                labelAdresse.text = adresse
            } else {
                labelAdresse.isHidden = true
            }
            if let phone = place?.phone {
                labelPhone.isHidden = false
                labelPhone.text = phone
            } else {
                labelPhone.isHidden = true
            }
            if let stops = place?.stops {
                stopsLabel.isHidden = false
                stopsLabel.text = stops
            } else {
                stopsLabel.isHidden = true
            }
            if let horaire = place?.schedule {
                scheduleLabel.isHidden = false
                scheduleLabel.text = horaire
            } else {
                scheduleLabel.isHidden = true
            }
        }
    }
}
