//
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
    var estadoData = LoadJson().estadoData
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureTableView()
        configureTableHeader()
        configureBackButton()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func configureBackButton(){
        view.addSubview(backButton)
//        let backButtonConfig = UIImage.SymbolConfiguration(textStyle: .largeTitle)
//        backButton.setImage(UIImage(systemName: "xmark.circle.fill", withConfiguration: backButtonConfig), for: .normal)
        //backButton.tintColor = UIColor(displayP3Red: 182/255, green: 182/255, blue: 182/255, alpha: 1)
        backButton.setImage(UIImage(named: "closeButton"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
    }
    
    func configureTableHeader(){
        let tableHeader = TableViewHeader(frame: CGRect(x:0, y: 0, width: view.frame.size.width, height: view.frame.size.height * 2/6))
        tableHeader.set(image:UIImage(named: estadoData[0].imagem)!, title: estadoData[0].nome)
        tableView.tableHeaderView = tableHeader
    }
    
    
    func configureTableView(){
        
        view.addSubview(tableView)
        setTableViewDelegate()
        tableView.register(InfoTextTableViewCell.self, forCellReuseIdentifier: InfoTextTableViewCell.identifier)
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
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoGraphicTableViewCell.identifier) as!
        InfoGraphicTableViewCell
        var entries = [BarChartDataEntry]()
        for x in 0..<10 {
            entries.append(BarChartDataEntry(x: Double(x), y: Double(x)))
        }
            
        cell.set(entries: entries, frame: .zero, estado: estadoData[0])
            
        return cell
            
    }
    
}
