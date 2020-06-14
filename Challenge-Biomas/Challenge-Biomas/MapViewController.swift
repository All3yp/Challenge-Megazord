//
//  ViewController.swift
//  Challenge-Biomas
//
//  Created by Alley Pereira  on 6/11/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.


import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create mapview and constraints
        let mapView = MKMapView()
        
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = view.frame.size.height
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false

        mapView.center = view.center
        
        view.addSubview(mapView)
        
        // Create button map
        let button = UIButton(type: .infoLight)
        button.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: 50)
        button.backgroundColor = UIColor.systemBackground
        button.layer.cornerRadius = 10
//        button.setTitle("Name Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
               
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Clicked")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}
