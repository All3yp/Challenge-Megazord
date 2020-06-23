//
//  InfoEspecificaCell.swift
//  Challenge-Biomas
//
//  Created by Helaine Pontes on 16/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

class InfoEspecificaCell: UITableViewCell {

    static let identifier = "InfoEspecificaCell"
    let titleLabel = UILabel()
    let detailLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureTitleLabel()
        configureDetailLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTitleLabel(){
        addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        titleLabel.numberOfLines = 0
        
        
        //Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
    }
    
    func configureDetailLabel(){
        addSubview(detailLabel)
        detailLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        detailLabel.numberOfLines = 0
        
        
        //Constraints
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }
    
    func configCell(bioma: Bioma, row: Int){
        switch row {
        case 0:
            titleLabel.text = "Vegetação"
            detailLabel.text = bioma.vegetacao
        case 1:
            titleLabel.text = "Hidrografia"
            detailLabel.text = bioma.hidrografia
        case 2:
            titleLabel.text = "Fauna"
            detailLabel.text = bioma.fauna
        case 3:
            titleLabel.text = "Curiosidades"
            detailLabel.text = bioma.curiosidades
        case 4:
            titleLabel.text = "Importância"
            detailLabel.text = bioma.importancia
        case 5:
            titleLabel.text = "Impactos Ambientais"
            detailLabel.text = bioma.impactos
        default: break
        }
    }
}
