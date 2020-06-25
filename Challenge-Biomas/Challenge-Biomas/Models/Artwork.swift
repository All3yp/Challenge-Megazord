//
//  Artwork.swift
//  Challenge-Biomas
//
//  Created by Paulo Uchôa on 16/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let area: String?
    let number: String?
    let coordinate: CLLocationCoordinate2D
  
    init(
        title: String?,
        area: String?,
        number: String?,
        coordinate: CLLocationCoordinate2D
      ) {
        self.title = title
        self.area = area
        self.number = number
        self.coordinate = coordinate
        
        super.init()
      }
  
      init?(feature: MKGeoJSONFeature) {
        // 1
        guard
          let point = feature.geometry.first as? MKPointAnnotation,
          // 2
          let propertiesData = feature.properties,
          let json = try? JSONSerialization.jsonObject(with: propertiesData),
          let properties = json as? [String: Any]
          else {
            return nil
        }
    
        // 3
        title = properties["title"] as? String
        area = properties["area"] as? String
        number = properties["number"] as? String
        coordinate = point.coordinate
        super.init()
      }
      
      var subtitle: String? {
        return area
      }

        var mapItem: MKMapItem? {
          guard let area = area else {
            return nil
          }
          
          let addressDict = [CNPostalAddressStreetKey: area]
          let placemark = MKPlacemark(
            coordinate: coordinate,
            addressDictionary: addressDict)
          let mapItem = MKMapItem(placemark: placemark)
          mapItem.name = title
          return mapItem
        }
}



