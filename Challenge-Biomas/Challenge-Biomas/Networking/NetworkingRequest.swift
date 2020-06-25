//
//  NetworkingRequest.swift
//  Challenge-Biomas
//
//  Created by Alley Pereira  on 6/25/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation


class Networking {
    
    
    
    static let route = "http://terrabrasilis.dpi.inpe.br/dashboard/api/v1/redis-cli/config/loinames"
    
    var gid: Int
    
    static let yearsRoute = "http://terrabrasilis.dpi.inpe.br/dashboard/api/v1/redis-cli/data/deforestation/\(gid)"
    
    
    
    static func requestLoiNames(completion: @escaping (LoisNameJson?) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string: route)!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("prodes_cerrado", forHTTPHeaderField: "App-Identifier")
        
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            data, response, error in
            if let error = error {
                print("Erro na requisição"+error.localizedDescription)
                completion(nil)
            }
            
            guard let data = data else {
                completion(nil)
                return
                
            }
            //print(String(bytes: data, encoding: .utf8))
            do {
                let loisJson = try JSONDecoder().decode(LoisNameJson.self, from: data)
                
                completion(loisJson)
                
            } catch {
                print("Erro no parse: "+error.localizedDescription)
                completion(nil)
            }
            
            
        }).resume()
        
   
    }
    
    
    static func requestYears(completion: @escaping) {
        
    }
}

