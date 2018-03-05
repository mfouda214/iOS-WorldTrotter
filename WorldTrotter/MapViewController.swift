//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Mohamed Sobhi  Fouda on 2/16/18.
//  Copyright © 2018 Mohamed Sobhi Fouda. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var mapView: MKMapView!
    var pinIndex: Int = 0
    var annotationList: [MKPointAnnotation]!
    
    override func loadView() {
        let p1 = MKPointAnnotation()
        p1.title = "Alghero"
        p1.coordinate = CLLocationCoordinate2D(latitude: 40.579693, longitude: 8.318887)
        let p2 = MKPointAnnotation()
        p2.title = "München"
        p2.coordinate = CLLocationCoordinate2D(latitude: 48.1367, longitude: 11.58862)
        let p3 = MKPointAnnotation()
        p3.title = "Moraine Lake"
        p3.coordinate = CLLocationCoordinate2D(latitude: 51.327847, longitude: -116.182474)
        annotationList = [p1, p2, p3]
        
        mapView = MKMapView()
        mapView.delegate = self
        view = mapView
        
        let randomLocationButton = UIButton()
        randomLocationButton.setTitle("Random Location", for: .normal)
        randomLocationButton.addTarget(self,
                                       action: #selector(getRandomLocation(_:)),
                                       for: .touchUpInside)
        randomLocationButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        randomLocationButton.setTitleColor(UIColor.black, for: .normal)
        randomLocationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(randomLocationButton)
        
        let topRandomLocationButtonConstraint =
            randomLocationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        let leadingRandomLocationButtonConstraint =
            randomLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingRandomLocationButtonConstraint =
            randomLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        topRandomLocationButtonConstraint.isActive = true
        leadingRandomLocationButtonConstraint.isActive = true
        trailingRandomLocationButtonConstraint.isActive = true
        
    }
    
    @objc func getRandomLocation(_ sender: UIButton) {
        let region = MKCoordinateRegionMakeWithDistance(annotationList[pinIndex].coordinate, 700, 700)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotationList[pinIndex])
        pinIndex += 1
        pinIndex = pinIndex % 3
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?  {
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "") as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotationList[pinIndex], reuseIdentifier: "")
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinTintColor = MKPinAnnotationView.purplePinColor()
        } else {
            pinView?.annotation = annotationList[pinIndex]
        }
        return pinView
    }
}
