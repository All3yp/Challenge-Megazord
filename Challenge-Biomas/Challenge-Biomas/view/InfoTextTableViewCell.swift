//
//  InfoTextTableViewCell.swift
//  Challenge-Biomas
//
//  Created by Felipe Santana on 16/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

class InfoTextTableViewCell: UITableViewCell {
    
    static let identifier = "InfoTextTableViewCell"
    
    var title = UILabel()
    var descriptionText = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(title)
        addSubview(descriptionText)
        configureAtributes()
        setTitleConstraints()
        setDescriptionTextConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(section: Section){
        title.text = section.title
        descriptionText.text = section.description
    }
    
    
    func configureAtributes() {
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true
        title.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        descriptionText.numberOfLines = 0
        descriptionText.adjustsFontSizeToFitWidth = true
        descriptionText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    func setTitleConstraints() {
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        
    }
    
    func setDescriptionTextConstraints() {
        
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        descriptionText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        descriptionText.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    
}
