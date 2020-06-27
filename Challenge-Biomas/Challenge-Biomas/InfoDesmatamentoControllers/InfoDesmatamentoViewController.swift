//  InfoDesmatamentoViewController.swift
//  Challenge-Biomas
//
//  Created by Felipe Santana on 16/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//
import Charts
import UIKit

class InfoDesmatamentoViewController: UIViewController {

    
    var tableView = UITableView()
    var backButton = UIButton()
    var estadoData = LoaderJson().estadoData
    var arrayGraphicData = [GraphicData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Networking.getAllGraphicDatas(estado: estadoData[MapViewController.b].nome) { (arrayGraphicData) in
            self.arrayGraphicData = arrayGraphicData
            for graphicData in arrayGraphicData {
                print(graphicData.bioma)
                print(graphicData.points.count)
            }
            self.tableView.reloadData()
        }
        configureTableView()
        configureTableHeader()
        configureBackButton()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc
    func buttonAction() {
        dismiss(animated: true, completion: nil)
        print("Button pressed")
    }
    
    func configureBackButton(){
        view.addSubview(backButton)
        backButton.setImage(UIImage(named: "Icone"), for: .normal)
        
        //action
        backButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
    }
    
    func configureTableHeader(){
        let tableHeader = TableViewHeader(frame: CGRect(x:0, y: 0, width: view.frame.size.width, height: view.frame.size.height * 2/6))
        tableHeader.set(image:UIImage(named: estadoData[MapViewController.b].imagem)!, title: estadoData[MapViewController.b].nome)
        tableView.tableHeaderView = tableHeader
    }
    
    
    func configureTableView(){
        
        view.addSubview(tableView)
        setTableViewDelegate()
        tableView.register(InfoGraphicTableViewCell.self, forCellReuseIdentifier: InfoGraphicTableViewCell.identifier)
        setTableViewConstraints()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
    }
    
    func setTableViewDelegate(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func setTableViewConstraints() {
       
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: super.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: super.view.bottomAnchor).isActive = true
        
    }

    
    
}


extension InfoDesmatamentoViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayGraphicData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoGraphicTableViewCell.identifier) as!
        InfoGraphicTableViewCell
        var entries = [BarChartDataEntry]()
        
        var samplePoints = arrayGraphicData[indexPath.row].points.sorted { (valueA, valueB) -> Bool in valueA.yearMonth < valueB.yearMonth }
        
        samplePoints.removeAll { (point) -> Bool in point.yearMonth < 2000 }
        
        samplePoints = samplePoints.enumerated().compactMap { (index, value) -> GraphicPoint? in
            if index == 0 { return nil }
            samplePoints[index].area += samplePoints[index-1].area
            return samplePoints[index]
        }
        
        
        samplePoints.forEach { point in
            entries.append(BarChartDataEntry(x: point.yearMonth, y: point.area))
        }
        
        let nome = arrayGraphicData[indexPath.row].bioma
        var nomeNew = ""
        switch nome {
        case .prodes_legal_amazon:
            nomeNew = "Amazônia"
        case .prodes_pampa:
            nomeNew = "Pampa"
        case .prodes_cerrado:
            nomeNew = "Cerrado"
        case .prodes_pantanal:
            nomeNew = "Pantanal"
        }
            
        cell.set(entries: entries, frame: .zero, estado: estadoData[MapViewController.b], nome: nomeNew)
            
        return cell
            
    }
    
}




