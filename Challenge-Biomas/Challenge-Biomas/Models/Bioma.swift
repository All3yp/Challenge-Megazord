//
//  Bioma.swift
//  Challenge-Biomas
//
//  Created by Helaine Pontes on 15/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation

//estrutura de dados dos biomas
//extend de Codable para permitir que o Json seja decodificado
struct Bioma: Codable {
    let imagem: String
    let nome: String
    let area: String
    let estados: String
    let clima: String
    let tNacional: String
    let vegetacao: String
    let hidrografia: String
    let fauna: String
    let curiosidades: String
    let importancia: String
    let impactos: String
}
