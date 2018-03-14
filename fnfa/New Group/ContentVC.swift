//
//  ContentVC.swift
//  ISHPullUpSample
//
//  Created by Yann Cherif on 12/03/2018.
//  Copyright © 2018 Yann Cherif. All rights reserved.
//

import MapKit
import ISHPullUp

class ContentVC: UIViewController, ISHPullUpContentDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 200
    var arrayDataSources : Array<Place> = []
    @IBOutlet private weak var rootView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

        if #available(iOS 11.0, *) {
            mapView.preservesSuperviewLayoutMargins = false
        } else {
            mapView.preservesSuperviewLayoutMargins = true
        }
        
        // Init the first Annotation
        arrayDataSources = DataMapper.instance.places
        let firstPlace = arrayDataSources[0]
        
        let initialLocation = CLLocation(latitude: firstPlace.lat!, longitude: firstPlace.long!)
        let firstLoc = Annotation(title: firstPlace.name!,
                                  locationName: firstPlace.adresse!,
                                  discipline: "Theatre",
                                  coordinate: CLLocationCoordinate2D(latitude: firstPlace.lat!,longitude: firstPlace.long!))
        
        centerMapOnLocation(location: initialLocation)
        mapView.addAnnotation(firstLoc)
        
        // Watch for new Anotations
        NotificationCenter.default.addObserver(self, selector: #selector(self.placeOnTheMap(_:)), name: .selectAPlace, object: nil)
    }
    
    
    //
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let location = view.annotation as! Annotation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
        
        print("yoooooo")
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        print("Teeeeeest")
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
                let annotation = Annotation(
                    title: placeToShow.name!,
                    locationName: placeToShow.adresse!,
                    discipline: "Theatre",
                    coordinate: CLLocationCoordinate2D(
                        latitude:  placeToShow.lat!,
                        longitude: placeToShow.long!
                    )
                )
                
                centerMapOnLocation(location: location)
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    
    /*
     *   Place the center of the map to the given coordonate
     */
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, self.regionRadius, self.regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
extension ViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Annotation else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
