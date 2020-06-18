//
//  BrasilMapOverlay.swift
//  Challenge-Biomas
//
//  Created by Paulo Uchôa on 15/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import MapKit

class BrasilMapOverlay: NSObject, MKOverlay {
  let coordinate: CLLocationCoordinate2D
  let boundingMapRect: MKMapRect

  init(brasil: Brasil) {
    boundingMapRect = brasil.overlayBoundingMapRect
    coordinate = brasil.midCoordinate
  }
}

