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
    let biomaData = LoadJson().biomaData
    let backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        configureTableHeader()
        configureBackButton()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func configureBackButton(){
        view.addSubview(backButton)
        let backButtonConfig = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        backButton.setImage(UIImage(systemName: "xmark.circle.fill", withConfiguration: backButtonConfig), for: .normal)
//        backButton.tintColor = UIColor(red: 223/255, green: 240/255, blue: 87/255, alpha: 1)
        backButton.tintColor = UIColor(red: 82/255, green: 82/255, blue: 82/255, alpha: 1)
        
        
        //Constraints
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    func configureTableHeader(){
        let tableHeader = TableViewHeader(frame: CGRect(x:0, y: 0, width: view.frame.size.width, height: 232))
        tableHeader.set(bioma: biomaData[0])
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
            cell.configCell(bioma: biomaData[0])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoEspecificaCell.identifier, for: indexPath) as! InfoEspecificaCell
            cell.configCell(bioma: biomaData[0], row: indexPath.row)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
