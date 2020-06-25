//
//  Brasil.swift
//  Challenge-Biomas
//
//  Created by Paulo Uchôa on 15/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import MapKit

class Brasil {
    
    private var artworks: [Artwork] = []

    var Caatinga: [CLLocationCoordinate2D] = []
    var Pampa: [CLLocationCoordinate2D] = []
    var MataAtlantica:[CLLocationCoordinate2D] = []
    var Pantanal:[CLLocationCoordinate2D] = []
    var Cerrado:[CLLocationCoordinate2D] = []
    var Amazonia:[CLLocationCoordinate2D] = []

    
    var midCoordinate = CLLocationCoordinate2D()
    var overlayTopLeftCoordinate = CLLocationCoordinate2D()
    var overlayTopRightCoordinate = CLLocationCoordinate2D()
    var overlayBottomLeftCoordinate = CLLocationCoordinate2D()
    var overlayBottomRightCoordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(
        latitude: overlayBottomLeftCoordinate.latitude,
        longitude: overlayTopRightCoordinate.longitude)
    }
    
//    var AmazoniaColor: String

    var overlayBoundingMapRect: MKMapRect {
        let topLeft = MKMapPoint(overlayTopLeftCoordinate)
        let topRight = MKMapPoint(overlayTopRightCoordinate)
        let bottomLeft = MKMapPoint(overlayBottomLeftCoordinate)

        return MKMapRect(
            x: topLeft.x,
            y: topLeft.y,
            width: fabs(topLeft.x - topRight.x),
            height: fabs(topLeft.y - bottomLeft.y))
    }

  init(filename: String) {

        guard
           let properties1 = Brasil.plist(filename) as? [String: Any],
           let BiomaPoints1 = properties1["Pampa"] as? [String]
           else { return }
    
        guard
            let properties2 = Brasil.plist(filename) as? [String: Any],
            let BiomaPoints2 = properties2["Caatinga"] as? [String]
            else { return }

        guard
            let properties3 = Brasil.plist(filename) as? [String: Any],
            let BiomaPoints3 = properties3["MataAtlantica"] as? [String]
            else { return }
    
        guard
            let properties4 = Brasil.plist(filename) as? [String: Any],
            let BiomaPoints4 = properties4["Pantanal"] as? [String]
            else { return }
    
        guard
            let properties5 = Brasil.plist(filename) as? [String: Any],
            let BiomaPoints5 = properties5["Cerrado"] as? [String]
            else { return }
    
        guard
            let properties6 = Brasil.plist(filename) as? [String: Any],
            let BiomaPoints6 = properties6["Amazonia"] as? [String]
            else { return }

    
       midCoordinate = Brasil.parseCoord(dict: properties1, fieldName: "midCoord")
    
        let cgPoints1 = BiomaPoints1.map { NSCoder.cgPoint(for: $0) }
         Pampa = cgPoints1.map { CLLocationCoordinate2D(
           latitude: CLLocationDegrees($0.x),
           longitude: CLLocationDegrees($0.y))
        }
            
        let cgPoints2 = BiomaPoints2.map { NSCoder.cgPoint(for: $0) }
        Caatinga = cgPoints2.map { CLLocationCoordinate2D(
          latitude: CLLocationDegrees($0.x),
          longitude: CLLocationDegrees($0.y))
        }

        let cgPoints3 = BiomaPoints3.map { NSCoder.cgPoint(for: $0) }
        MataAtlantica = cgPoints3.map { CLLocationCoordinate2D(
          latitude: CLLocationDegrees($0.x),
          longitude: CLLocationDegrees($0.y))
        }
        
        let cgPoints4 = BiomaPoints4.map { NSCoder.cgPoint(for: $0) }
        Pantanal = cgPoints4.map { CLLocationCoordinate2D(
          latitude: CLLocationDegrees($0.x),
          longitude: CLLocationDegrees($0.y))
        }
        
        let cgPoints5 = BiomaPoints5.map { NSCoder.cgPoint(for: $0) }
        Cerrado = cgPoints5.map { CLLocationCoordinate2D(
          latitude: CLLocationDegrees($0.x),
          longitude: CLLocationDegrees($0.y))
        }
        
        let cgPoints6 = BiomaPoints6.map { NSCoder.cgPoint(for: $0) }
        Amazonia = cgPoints6.map { CLLocationCoordinate2D(
          latitude: CLLocationDegrees($0.x),
          longitude: CLLocationDegrees($0.y))
        }

//        let cgPoints8 = BiomaPoints8.map { NSCoder.cgPoint(for: $0) }
//        Amazonas = cgPoints8.map { CLLocationCoordinate2D(
//            latitude: CLLocationDegrees($0.x),
//            longitude: CLLocationDegrees($0.y))
//        }

}

//Carrega o arquivo .plist
  static func plist(_ plist: String) -> Any? {
    guard let filePath = Bundle.main.path(forResource: plist, ofType: "plist"),
      let data = FileManager.default.contents(atPath: filePath) else { return nil }

    do {
      return try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
    } catch {
      return nil
    }
  }

  static func parseCoord(dict: [String: Any], fieldName: String) -> CLLocationCoordinate2D {
    if let coord = dict[fieldName] as? String {
      let point = NSCoder.cgPoint(for: coord)
      return CLLocationCoordinate2D(
        latitude: CLLocationDegrees(point.x),
        longitude: CLLocationDegrees(point.y))
    }
    return CLLocationCoordinate2D()
  }
}
