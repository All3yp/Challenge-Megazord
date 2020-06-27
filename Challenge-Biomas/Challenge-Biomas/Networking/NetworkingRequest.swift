//
//  NetworkingRequest.swift
//  Challenge-Biomas
//
//  Created by Alley Pereira  on 6/25/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation


// Como pegar todos os Dados pros GRaficos (GraphicData) | se quiser testar antes poe no AppDelegate
/*
 
 Networking.getAllGraphicDatas(estado: "Mato Grosso") { (arrayGraphicData) in
     for graphicData in arrayGraphicData {
         print(graphicData.bioma)
         print(graphicData.points.count)
     }
 }
 
 */

class Networking {
    
    
    static let loinamesRouteURL = URL(string: "http://terrabrasilis.dpi.inpe.br/dashboard/api/v1/redis-cli/config/loinames")!
    static let deforestationRouteURL =  URL(string: "http://terrabrasilis.dpi.inpe.br/dashboard/api/v1/redis-cli/data/deforestation")! //passar gid pela funcao
    
    static func requestLoiNames(bioma: ProdBiomas, completion: @escaping (LoisNameJson?) -> Void) {
        
        var urlRequest = URLRequest(url: loinamesRouteURL)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(bioma.rawValue, forHTTPHeaderField: "App-Identifier")
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            data, response, error in
            if let error = error {
                print("Erro na requisição"+error.localizedDescription)
                completion(nil)
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Response nao é HTTP")
                completion(nil)
                return
            }
            print("Status Code: \(response.statusCode)")
            
            DispatchQueue.main.async{
                guard let data = data else {
                    print("Data veio nulo")
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
            }
            
        }).resume()
        
        
    }
    
    
    static func requestDeforestation(bioma: ProdBiomas, gid: Int, completion: @escaping (DeforestationJSON?) -> Void) {
        
        var urlRequest = URLRequest(url: deforestationRouteURL.appendingPathComponent("\(gid)"))
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(bioma.rawValue, forHTTPHeaderField: "App-Identifier")
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            data, response, error in
            if let error = error {
                print("Deu erro aq oh tio"+error.localizedDescription)
                completion(nil)
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Response nao é HTTP")
                completion(nil)
                return
            }
            print("Status Code: \(response.statusCode)")
            
            DispatchQueue.main.async{
                guard let data = data else {
                    print("Data veio nulo")
                    completion(nil)
                    return
                }
                
                do {
                    let deforestationJson = try JSONDecoder().decode(DeforestationJSON.self, from: data)
                    completion(deforestationJson)
                    
                } catch {
                    print("Eeeeerro no parse: "+error.localizedDescription)
                    completion(nil)
                }
            }
            
        }).resume()
    }
    
    static func requestGraphicData(bioma: ProdBiomas, estadoSelecionado: String, completion: @escaping (GraphicData?) -> Void) {
        
        Networking.requestLoiNames(bioma: bioma) { (loinamesJson) in
            guard let loinamesJson = loinamesJson else {
                completion(nil)
                return
            }
            
            let ufFilterResult = loinamesJson.lois.filter { loi in loi.name == "uf" }
            //print(ufFilterResult)
            
            guard let ufLoi: Lois = ufFilterResult.first else {
                completion(nil)
                return
            }
            
            let loinameDoEstadoSelecionado = ufLoi.loinames.first(where: { loiname in
                loiname.loiname == estadoSelecionado.uppercased()
            })
            
            guard let loiname = loinameDoEstadoSelecionado else {
                print("Não encontrou o estado \(estadoSelecionado) para o bioma \(bioma.rawValue).")
                completion(nil)
                return
            }
            
            let gid = loiname.gid //preciso pra request de deforestation do gid
            
            print("\nBioma: "+bioma.rawValue)
            print("Estado: "+estadoSelecionado.uppercased())
            print(Networking.deforestationRouteURL.appendingPathComponent("\(gid)").absoluteString)
            
            //Requisicao pegando dados de deforestation
            
            Networking.requestDeforestation(bioma: bioma, gid: gid) { (deforastationJson) in
                guard let deforestation = deforastationJson else {
                    completion(nil)
                    return
                }
                
                var graphicData: GraphicData = GraphicData(bioma: bioma, points: [])
                
                for period in deforestation.periods {
                    for feature in period.features {
                        for areaFeature in feature.areas {
                            
                            if areaFeature.type == 2 {
                                
                                let yearMonthString = "\(period.startDate.year).\(period.startDate.month)"
                                
                                let graphicPoint = GraphicPoint(yearMonth: Double(yearMonthString)!,
                                                                area: areaFeature.area) // criacao de um novo ponto pro grafico
                                graphicData.points.append(graphicPoint)
                                
                                
                                
//                            } else if areaFeature.type == 2 {
//                                let yearMonthString = "\(period.endDate.year).\(period.endDate.month)"
//
//                                let graphicPoint = GraphicPoint(yearMonth: Double(yearMonthString)!, area: areaFeature.area)
//
//                                graphicData.points.append(graphicPoint)
//
//
                            }
                            
                        }
                    }
                }
                
                completion(graphicData)
            }
            
        }
    }
    
    static func getAllGraphicDatas(estado: String, completion: @escaping ([GraphicData]) -> Void) {
        
        var allGraphicDatas: [GraphicData] = []
        var contadorRetorno = 0
        
        for bioma in ProdBiomas.allCases {
            Networking.requestGraphicData(bioma: bioma, estadoSelecionado: estado) { (graphicData) in
                
                print("Bioma: \(graphicData?.bioma.rawValue) ", "Pontos do gráfico: \(graphicData?.points)")
                
                if let graphicData = graphicData {
                    allGraphicDatas.append(graphicData)
                }

                contadorRetorno += 1
                if contadorRetorno >= ProdBiomas.allCases.count {
                    completion(allGraphicDatas)
                }
            }
        }
    }
    
    
}




