//
//  LoadGeoJson.swift
//  Challenge-Biomas
//
//  Created by Helaine Pontes on 25/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//
import MapKit
import Foundation

public class LoadGeoJson{
    
    var artworks: [Artwork] = []
    var estateartworks: [EstateArtwork] = []
    
    init(){
        loadInitialData()
        loadInitialDataEstate()
    }
    //    Função que carrega o geojson ao iniciar o aplicativo
    func loadInitialData() {
      // 1
      guard
        let fileName = Bundle.main.url(forResource: "BioPoints", withExtension: "geojson")

        else {
          return
      }

      do {
        // 2
        let artworkData = try Data(contentsOf: fileName)
        let features = try MKGeoJSONDecoder()
          .decode(artworkData)
          .compactMap { $0 as? MKGeoJSONFeature }
        // 3
        let validWorks = features.compactMap(Artwork.init)
        // 4
        artworks.append(contentsOf: validWorks)
      } catch {
        // 5
        print("Unexpected error: \(error).")
      }
    }
    
    
    func loadInitialDataEstate() {
      // 1
      guard
        let fileName2 = Bundle.main.url(forResource: "EstatePoints", withExtension: "geojson")

        else {
          return
      }

      do {
        // 2
        let artworkData2 = try Data(contentsOf: fileName2)
        let features2 = try MKGeoJSONDecoder()
          .decode(artworkData2)
          .compactMap { $0 as? MKGeoJSONFeature }
        // 3
        let validWorks2 = features2.compactMap(EstateArtwork.init)
        // 4
        estateartworks.append(contentsOf: validWorks2)
      } catch {
        // 5
        print("Unexpected error: \(error).")
      }
    }
}
