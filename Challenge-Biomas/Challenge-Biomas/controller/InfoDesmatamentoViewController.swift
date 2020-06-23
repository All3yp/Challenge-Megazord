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
    var sections: [Section] = []
    var backButton = UIButton(type: .close)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        sections = fetchData()
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
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
    }
    
    func configureTableHeader(){
        let tableHeader = TableViewHeader(frame: CGRect(x:0, y: 0, width: view.frame.size.width, height: 232))
        tableHeader.set(image:UIImage(named: "amazonia")!, title: "Amazonia")
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
        tableView.leadingAnchor.constraint(equalTo: super.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: super.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: super.view.bottomAnchor).isActive = true
        
    }
    
    
}


extension InfoDesmatamentoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return sections.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoGraphicTableViewCell.identifier) as! InfoGraphicTableViewCell
            //let frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width)
            var entries = [BarChartDataEntry]()
            for x in 0..<10 {
                entries.append(BarChartDataEntry(x: Double(x), y: Double(x)))
            }
            
            let section = Section(title: "Gráfico", description: "Breve descrição do desmatamento na área")
            cell.set(entries: entries, frame: .zero, section: section)
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTextTableViewCell") as! InfoTextTableViewCell
            let section = sections[indexPath.row]
            cell.set(section: section)
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
}


extension InfoDesmatamentoViewController {
    
    func fetchData() -> [Section] {
        
        let section1 = Section(title: "Hidrografia", description: "A bacia amazônica é a maior bacia hidrográfica do mundo e seu principal rio, o Amazonas, é o maior rio do mundo em volume de água com mais de 7 mil afluentes.Outros rios que fazem parte da hidrografia da Amazônia são: Araguaia, Nhamundá, Negro, Solimões, Tocantins, Trombetas, Xingu, Purus, Juruá, Japurá, Madeira, Tapajós, Branco.")
        let section2 = Section(title: "Hidrografia", description: "A bacia amazônica é a maior bacia hidrográfica do mundo e seu principal rio, o Amazonas, é o maior rio do mundo em volume de água com mais de 7 mil afluentes.Outros rios que fazem parte da hidrografia da Amazônia são: Araguaia, Nhamundá, Negro, Solimões, Tocantins, Trombetas, Xingu, Purus, Juruá, Japurá, Madeira, Tapajós, Branco.")
        let section3 = Section(title: "Hidrografia", description: "A bacia amazônica é a maior bacia hidrográfica do mundo e seu principal rio, o Amazonas, é o maior rio do mundo em volume de água com mais de 7 mil afluentes.Outros rios que fazem parte da hidrografia da Amazônia são: Araguaia, Nhamundá, Negro, Solimões, Tocantins, Trombetas, Xingu, Purus, Juruá, Japurá, Madeira, Tapajós, Branco.")
        let section4 = Section(title: "Hidrografia", description: "A bacia amazônica é a maior bacia hidrográfica do mundo e seu principal rio, o Amazonas, é o maior rio do mundo em volume de água com mais de 7 mil afluentes.Outros rios que fazem parte da hidrografia da Amazônia são: Araguaia, Nhamundá, Negro, Solimões, Tocantins, Trombetas, Xingu, Purus, Juruá, Japurá, Madeira, Tapajós, Branco.")
        let section5 = Section(title: "Hidrografia", description: "A bacia amazônica é a maior bacia hidrográfica do mundo e seu principal rio, o Amazonas, é o maior rio do mundo em volume de água com mais de 7 mil afluentes.Outros rios que fazem parte da hidrografia da Amazônia são: Araguaia, Nhamundá, Negro, Solimões, Tocantins, Trombetas, Xingu, Purus, Juruá, Japurá, Madeira, Tapajós, Branco.")
        let section6 = Section(title: "Hidrografia", description: "A bacia amazônica é a maior bacia hidrográfica do mundo e seu principal rio, o Amazonas, é o maior rio do mundo em volume de água com mais de 7 mil afluentes.Outros rios que fazem parte da hidrografia da Amazônia são: Araguaia, Nhamundá, Negro, Solimões, Tocantins, Trombetas, Xingu, Purus, Juruá, Japurá, Madeira, Tapajós, Branco.")
        
        return [section1, section2, section3, section4, section5, section6]
    }
    
}
