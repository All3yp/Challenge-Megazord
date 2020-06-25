//
//  InfoBiomaViewController.swift
//  Challenge-Biomas
//
//  Created by Helaine Pontes on 15/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

class InfoBiomaViewController: UIViewController {
    
    let tableView = UITableView()
    let backButton = UIButton()
    let biomaData = LoaderJson().biomaData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
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
        
        //Ação do Botão
        backButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        //Constraints
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    func configureTableHeader(){
        let tableHeader = HeaderView(frame: CGRect(x:0, y: 0, width: view.frame.size.width, height: 232))
        tableHeader.set(bioma: biomaData[MapViewController.b])
        tableView.tableHeaderView = tableHeader
    }
    
    func configureTable(){
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.delegate = self
        tableView.sectionHeaderHeight = 100
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        
        
        //Cell Registers
        let cellNib = UINib(nibName: InfoGeraisCell.xibName, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: InfoGeraisCell.identifier)
        tableView.register(InfoEspecificaCell.self, forCellReuseIdentifier: InfoEspecificaCell.identifier)
    }
}
extension InfoBiomaViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 6
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoGeraisCell.identifier, for: indexPath) as! InfoGeraisCell
            cell.configCell(bioma: biomaData[MapViewController.b])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoEspecificaCell.identifier, for: indexPath) as! InfoEspecificaCell
            cell.configCell(bioma: biomaData[MapViewController.b], row: indexPath.row)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
