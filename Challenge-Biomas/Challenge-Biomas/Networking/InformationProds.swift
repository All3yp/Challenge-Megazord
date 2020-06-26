//
//  InformationProds.swift
//  Challenge-Biomas
//
//  Created by Alley Pereira  on 6/25/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation

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
    let name: String
    let loinames: [LoiName]
}

struct LoiName: Decodable { // JSON mais interno
    let gid: Int
    let loiname: String
}

struct DeforestationJSON: Decodable {
    let periods: [PeriodsJSON]
}

struct PeriodsJSON: Decodable {
    let startDate: DateJSON
    let endDate: DateJSON
}

struct DateJSON: Decodable {
    let year: Int
    let month: Int
    let day: Int
}

enum ProdBiomas: String {

     case prodes_pampa
     case prodes_cerrado
     case prodes_legal_amazon
     case prodes_pantanal
     case prodes_amazon

 }
