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
    
    
    static var gid: Int { //passar por parametro
        get {
            return 1
        }
        set {
            
        }
    }
    
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
    
    
    static func requestYears(completion: @escaping (DeforestationJSON?) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string: yearsRoute)!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(ProdBiomas.prodes_cerrado.rawValue, forHTTPHeaderField: "App-Identifier")
//        urlRequest.forHTTPHeaderField: "App-Identifier"
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            data, response, error in
            if let error = error {
                print("Deu erro aq oh tio"+error.localizedDescription)
                completion(nil)
            }
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let periodsJson = try JSONDecoder().decode(DeforestationJSON.self, from: data)
                
                completion(periodsJson)
                
            } catch {
                print("Eeeeerro no parse: "+error.localizedDescription)
                completion(nil)
            }
            
        }).resume()
    }
}

