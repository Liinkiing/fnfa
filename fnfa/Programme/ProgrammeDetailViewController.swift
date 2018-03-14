//
//  ProgrammeDetailViewController.swift
//  fnfa
//
//  Created by Jbara Omar on 12/03/2018.
//  Copyright © 2018 JBARA Omar. All rights reserved.
//

import UIKit

class ProgrammeDetailViewController: UIViewController {
    
    @IBOutlet weak var labelPlace: UILabel!
    @IBOutlet weak var labelExcerpt: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var buttonShowMore: UIButton!
    @IBOutlet weak var labelProducer: UILabel!
    @IBOutlet weak var labelDirector: UILabel!
    @IBOutlet weak var labelAudience: UILabel!
    
    var event: Event?

    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    func setup() {
        if(event?.image == "random") {
            imageView.image = event?.getPlaceholderImage()
        } else {
            imageView.sd_setImage(with: URL(string: (event?.image)!), placeholderImage: event?.getPlaceholderImage())
        }
        title = event?.name
        labelPlace.text = event?.places?.first?.name
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("HH:mm")
        labelDuration.text = "\(df.string(from: (event?.startingDate.getDate())!)) - \(df.string(from: (event?.endingDate.getDate())!))"
        labelExcerpt.text = event?.excerpt
        labelAudience.text = (event?.audience != nil ? "A partir de \((event?.audience!)!) ans" : "Pour tous public")
        labelDirector.text = event?.director
        labelProducer.text = event?.producer
    }

    @IBAction func onButtonMoreTapped(_ sender: UIButton) {
        if let url = URL(string: (event?.url)!) {
            UIApplication.shared.open(url)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
