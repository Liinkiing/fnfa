//
//  ProgrammeViewController.swift
//  fnfa
//
//  Created by JBARA Omar on 15/02/2018.
//  Copyright © 2018 JBARA Omar. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class ProgrammeViewController: UIViewController, UICollectionViewDelegate {


    @IBOutlet weak var programmeCollectionView: UICollectionView!
    
    @IBOutlet weak var programmeFlowLayout: UPCarouselFlowLayout!
    
    var programmeDataSource: ProgrammeDataSource
    
    @IBOutlet weak var timeline: TimeLineControl!
    
    @IBAction func filterButtonTap(_ sender: FilterButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            programmeDataSource.filters.append(sender.filter!)
        } else {
            programmeDataSource.filters = programmeDataSource.filters.filter { return $0 != sender.filter }
        }
        programmeDataSource.events = programmeDataSource.filter()
        programmeCollectionView.reloadData()
        programmeCollectionView.performBatchUpdates({
            
        }) { (finished) in
            self.updateTimeline()
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        programmeDataSource = ProgrammeDataSource(events: DataMapper.instance.events.sorted(by: .date)!)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        timeline.delegate = self
        programmeCollectionView.delegate = self
        programmeFlowLayout.spacingMode = .overlap(visibleOffset: 30)
        programmeCollectionView.register(UINib(nibName: String(describing: ProgrammeCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProgrammeCollectionViewCell.self))
        programmeCollectionView.dataSource = programmeDataSource
        programmeCollectionView.reloadData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateTimeline()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updateTimeline()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(!decelerate) {
            updateTimeline()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "eventDetail", sender: programmeDataSource.events[indexPath.item])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "eventDetail") {
            let event = sender as! Event
            let destination = segue.destination as! ProgrammeDetailViewController
            destination.event = event
        }
        
    }

    private func updateTimeline() {
        let visibleRect = CGRect(origin: programmeCollectionView.contentOffset, size: programmeCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let indexPath = programmeCollectionView.indexPathForItem(at: visiblePoint)
        programmeCollectionView.performBatchUpdates({
            
        }) { (finished) in
            if let cell = self.programmeCollectionView.cellForItem(at: indexPath!) as! ProgrammeCollectionViewCell? {
                self.timeline.setStep((cell.event?.startingDate.day)! - 3)
                let df = DateFormatter()
                df.locale = Locale(identifier: "fr_FR")
                df.setLocalizedDateFormatFromTemplate("EE dd")
                self.timeline.timelineLabelValue = df.string(from: (cell.event?.startingDate.getDate())!).capitalized
            }
        }
       
    }

}

extension ProgrammeViewController: TimeLineControlDelegate {
    
    func userAddedStep(_ value: Int) {
        let event = programmeDataSource.getFirstEvent(ofDay: value + 3)
        let index = programmeDataSource.events.index(of: event)
        programmeCollectionView.selectItem(at: IndexPath(item: index!, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func userRemovedStep(_ value: Int) {
        let event = programmeDataSource.getFirstEvent(ofDay: value + 3)
        let index = programmeDataSource.events.index(of: event)
        programmeCollectionView.selectItem(at: IndexPath(item: index!, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func userIsDragging(_ values: Array<CGFloat>) {
        
    }
    
    func userDidEndDrag(_ values: Array<CGFloat>) {
        
    }
}
