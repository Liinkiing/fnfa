//
//  ContentVC.swift
//  ISHPullUpSample
//
//  Created by Yann Cherif on 12/03/2018.
//  Copyright © 2018 Yann Cherif. All rights reserved.
//

import MapKit
import ISHPullUp

class ContentVC: UIViewController, ISHPullUpContentDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    var arrayDataSources : Array<Place> = []
    @IBOutlet private weak var rootView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            mapView.preservesSuperviewLayoutMargins = false
        } else {
            mapView.preservesSuperviewLayoutMargins = true
        }
        
        // Init the first Annotation
        arrayDataSources = DataMapper.instance.places
        let firstPlace = arrayDataSources[0]
        
        let initialLocation = CLLocation(latitude: firstPlace.lat!,longitude: firstPlace.long!)
        centerMapOnLocation(location: initialLocation)
        
        let firstLoc = Annotation(title: firstPlace.name!,
                              locationName: firstPlace.adresse!,
                              discipline: "Theatre",
                              coordinate: CLLocationCoordinate2D(latitude: firstPlace.lat!,longitude: firstPlace.long!))
        mapView.addAnnotation(firstLoc)
        
        // Watch for new Anotations
        NotificationCenter.default.addObserver(self, selector: #selector(self.placeOnTheMap(_:)), name: .selectAPlace, object: nil)
    }

    
    

    
    // MARK: ISHPullUpContentDelegate
    func pullUpViewController(_ vc: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forContentViewController _: UIViewController) {
        if #available(iOS 11.0, *) {
            additionalSafeAreaInsets = edgeInsets
            rootView.layoutMargins = .zero
        } else {
            // update edgeInsets
            rootView.layoutMargins = edgeInsets
        }

        // call layoutIfNeeded right away to participate in animations
        // this method may be called from within animation blocks
        rootView.layoutIfNeeded()
    }
    
    
    
    /*  ==========================================================
     == Helper Functions ==
     ======================================================= */
    
    /*
    *   Place the Annotion on the Map
    */
    @objc func placeOnTheMap (_ notification: NSNotification) {
        if let payload = notification.userInfo as? [String: Any] {
            if let placeToShow = payload["place"] as? Place {
                let location = CLLocation(latitude: placeToShow.lat!,longitude: placeToShow.long!)
                centerMapOnLocation(location: location)
                let annotation = Annotation(
                    title: placeToShow.name!,
                    locationName: placeToShow.adresse!,
                    discipline: "Theatre",
                    coordinate: CLLocationCoordinate2D(
                        latitude:  placeToShow.lat!,
                        longitude: placeToShow.long!
                    )
                )
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    
    /*
     *   Place the center of the map to the given coordonate
     */
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
