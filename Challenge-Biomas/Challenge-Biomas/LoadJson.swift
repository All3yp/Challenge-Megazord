//
//  LoadJson.swift
//  Challenge-Biomas
//
//  Created by Felipe Santana on 24/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation


class LoadJson {
    
    @Published var estadoData = [Estado]()
    
    init() {
        
        load()
        
    }
    
    
    func load() {
        
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
