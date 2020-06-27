//
//  InformationProds.swift
//  Challenge-Biomas
//
//  Created by Alley Pereira  on 6/25/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation

//MARK: - Modelo de loinames

struct LoisNameJson: Decodable {  // Representa JSON externo ( primeiras chaves do JSON )
    let data: LoisNameData
    let lois: [Lois]
}

struct LoisNameData: Decodable { // Representa o Json do Data
    let id: Int
    let name: String
    let description: String
}

struct Lois: Decodable {  // Array de JSONS
    let name: String //uf
    let loinames: [LoiName]
}

struct LoiName: Decodable { // JSON mais interno
    let gid: Int
    let loiname: String //
}



//MARK: - Modelo do deforestation

struct DeforestationJSON: Decodable {
    let periods: [PeriodsJSON]
}

struct PeriodsJSON: Decodable {
    let startDate: DateJSON
    let endDate: DateJSON
    let features: [FeaturesJSON]
}

struct DateJSON: Decodable {
    let year: Int
    let month: Int
//    let day: Int
}

struct FeaturesJSON: Decodable {
    let areas: [AreasFeatureJson]
}

struct AreasFeatureJson: Decodable {
    let type: Int
    let area: Double
}

//MARK: - Modelo para o Gráfico
struct GraphicPoint {
    let yearMonth: Double
    let area: Double
}

struct GraphicData {
    let bioma: ProdBiomas
    var points: [GraphicPoint]
}


// MARK: - Enum de biomas :)

enum ProdBiomas: String, CaseIterable {

     case prodes_pampa
     case prodes_cerrado
     case prodes_legal_amazon
     case prodes_pantanal
     case prodes_amazon

 }
