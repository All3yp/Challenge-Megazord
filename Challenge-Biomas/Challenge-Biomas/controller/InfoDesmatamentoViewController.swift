//
//  InfoDesmatamentoViewController.swift
//  Challenge-Biomas
//
//  Created by Felipe Santana on 16/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

class InfoDesmatamentoViewController: UIViewController {

    
    var tableView = UITableView()
    var sections: [Section] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        sections = fetchData()
        configureTableView()
        configureTableHeader()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func configureTableHeader(){
        let tableHeader = TableViewHeader(frame: CGRect(x:0, y: 0, width: view.frame.size.width, height: 232))
        tableHeader.set(image:UIImage(named: "amazonia")!, title: "Amazonia")
        tableView.tableHeaderView = tableHeader
    }
    
    
    func configureTableView(){
        
        view.addSubview(tableView)
        setTableViewDelegate()
        tableView.register(InfoTextTableViewCell.self, forCellReuseIdentifier: "InfoTextTableViewCell")
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTextTableViewCell") as! InfoTextTableViewCell
        let section = sections[indexPath.row]
        cell.set(section: section)
        
        return cell
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
