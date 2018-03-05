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
    // MARK: - Property
    
    var mapView: MKMapView!
    
    var index: Int!                                                                       // my add for the Gold Challenge
    
    var coordinate1, coordinate2, coordinate3: CLLocationCoordinate2D!                    // my add for the Gold Challenge
    
    var string1 = "Alghero"                                                               // my add for the Gold Challenge
    var string1s = "The town where I was born"                                            // my add for the Gold Challenge
    var string2 = "München"                                                               // my add for the Gold Challenge
    var string2s = "The town where I live now"                                            // my add for the Gold Challenge
    var string3 = "Moraine Lake"                                                          // my add for the Gold Challenge
    var string3s = "The place where I would like to live"                                 // my add for the Gold Challenge
    
    // MARK: - UIViewController Method
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        mapView.delegate = self                                                           // my add for the Gold Challenge
        
        coordinate1 = CLLocationCoordinate2D(latitude: 40.579693, longitude: 8.318887)    // my add for the Gold Challenge
        coordinate2 = CLLocationCoordinate2D(latitude: 48.1367, longitude: 11.58862)      // my add for the Gold Challenge
        coordinate3 = CLLocationCoordinate2D(latitude: 51.327847, longitude: -116.182474) // my add for the Gold Challenge
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        /* ---------------------- my add for the Gold Challenge: create a button programmatically --------------------- */
        
        let button   = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        button.setTitle("Pin Location", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(MapViewController.buttonAction(sender:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        let bottomConstraintBtn = button.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -10)
        let marginsBtn = view.layoutMarginsGuide
        let leadingConstraintBtn = button.leadingAnchor.constraint(equalTo: marginsBtn.leadingAnchor)
        let trailingConstraintBtn = button.trailingAnchor.constraint(equalTo: marginsBtn.trailingAnchor)
        
        bottomConstraintBtn.isActive = true
        leadingConstraintBtn.isActive = true
        trailingConstraintBtn.isActive = true
        
        /* ------------------------------------------------------------------------------------------------------------ */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view.")
    }
    
    // MARK: - Helper Methods
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break }
    }
    
    // my add for the Gold Challenge
    @objc func buttonAction(sender: UIButton!) {
        switch index {
        case nil, 2:
            index = 0
            point(title: string1, subTitle: string1s, coordinate: coordinate1)
        case 0:
            index = 1
            point(title: string2, subTitle: string2s, coordinate: coordinate2)
        case 1:
            index = 2
            point(title: string3, subTitle: string3s, coordinate: coordinate3)
        default:
            break
        }
    }
    
    // my add for the Gold Challenge
    private func point(title: String!, subTitle: String!, coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 700, 700)
        mapView.setRegion(region, animated: true)
        
        let point = MKPointAnnotation()
        point.coordinate = coordinate
        point.title = title
        point.subtitle = subTitle
        mapView.addAnnotation(point)
    }
    
    // MARK: - MKMapViewDelegate Method
    
    // my add for the Gold Challenge
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?  {
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "Test") as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Test")
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinTintColor = MKPinAnnotationView.purplePinColor()   // or: "pinView!.pinTintColor = UIColor.purple"
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView                                                                                       // return nil
    }
}
