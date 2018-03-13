//
//  ContentVC.swift
//  ISHPullUpSample
//
//  Created by Felix Lamouroux on 27.06.16.
//  Copyright © 2016 iosphere GmbH. All rights reserved.
//

import MapKit
import ISHPullUp

class ContentVC: UIViewController, ISHPullUpContentDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000

    // we use a root view to rely on the edge inset
    // (this cannot be set on the VC's view directly)
    @IBOutlet private weak var rootView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The mapView should preserve the rootView's layout margins only
        // on iOS 10 and earlier to correctly update the legal label
        // and coordinate region.
        // On iOS 11 and later this is done automatically via the safeAreaInsets.
        if #available(iOS 11.0, *) {
            mapView.preservesSuperviewLayoutMargins = false
        } else {
            mapView.preservesSuperviewLayoutMargins = true
        }
        
        
        let initialLocation = CLLocation(latitude: 48.858053,longitude: 2.294289)
        centerMapOnLocation(location: initialLocation)
        
        let test = Annotation(title: "Un Test",
                              locationName: "D'une incorayable beauté",
                              discipline: "Devellopement",
                              coordinate: CLLocationCoordinate2D(latitude: 48.858053, longitude: 2.294289))
        mapView.addAnnotation(test)
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
    
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
