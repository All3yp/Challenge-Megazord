//
//  LoadJson.swift
//  Challenge-Biomas
//
//  Created by Helaine Pontes on 15/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation

public class LoadJson{
    var biomaData = [Bioma]()
    
    init(){
        load()
    }
    
    func load(){
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
}

