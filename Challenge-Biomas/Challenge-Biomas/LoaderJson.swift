//
//  LoaderJson.swift
//  Challenge-Biomas
//
//  Created by Helaine Pontes on 25/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation

public class LoaderJson{
    var biomaData = [Bioma]()
    var estadoData = [Estado]()
    
    init(){
        loadBioma()
        loadEstados()
    }
    
    func loadBioma(){
        if let fileLocation = Bundle.main.url(forResource: "BiomasData", withExtension: "json"){
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Bioma].self, from: data)
                self.biomaData = dataFromJson
            } catch{
                print(error)
            }
        }
    }
    
    func loadEstados() {
    
    if let fileLocation = Bundle.main.url(forResource: "EstadosData", withExtension: "json"){
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Estado].self, from: data)
                self.estadoData = dataFromJson
            } catch{
                print(error)
            }
        }
    }
}
