//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Mohamed Sobhi  Fouda on 2/16/18.
//  Copyright © 2018 Mohamed Sobhi Fouda. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //Override viewWillAppear(_:) if you need the configuration to be done each time the view controller’s view appears onscreen
    
    var mapView: MKMapView!
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        
//        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.topAnchor)

        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
       
//        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
       
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
    }
    
}

