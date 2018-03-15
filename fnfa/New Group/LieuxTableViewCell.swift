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
    @IBOutlet weak var busholder: UIView!
    
    @IBOutlet weak var btnLabel: UIButton!
    
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
                btnLabel.isHidden = false
                btnLabel.setTitle(phone, for: .normal)
                btnLabel.setTitle(phone, for: .selected)
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
            if let bus = place?.bus {
                scheduleLabel.isHidden = false
                creatBusliste(busesListe: bus)
            } else {
                scheduleLabel.isHidden = true
            }
        }
    }
    
    @IBAction func phoneCall(_ sender: UIButton) {
        let string = sender.titleLabel?.text?.removingWhitespaces()
        if let url = URL(string: "tel://\(string!)") {
            UIApplication.shared.open(url)
        }
    }
    
    func creatBusliste(busesListe: Array<String>) {
        for i in 0...busesListe.count-1 {
            let x = i==0 ? 0 : i * 15 + 4*i
            let name = busesListe[i]
            var imageView : UIImageView
            imageView  = UIImageView(frame: CGRect(x: CGFloat(x) ,y: 0, width: 15 , height:15));
            imageView.image = UIImage(named:name)
            busholder.addSubview(imageView)
        }
    }
    
}
