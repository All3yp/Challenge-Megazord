//
//  TableViewHeader.swift
//  Challenge-Biomas
//
//  Created by Felipe Santana on 17/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

class TableViewHeader: UIView {
    
    var imageView = UIImageView()
    var titleLabel = UILabel()
    var shadowMask = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(shadowMask)
        addSubview(titleLabel)
        configureShadowMask()
        configureImageView()
        configureTitleLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage, title: String){
        
        self.imageView.image = image
        self.titleLabel.text = title
        
    }
    
    func configureShadowMask() {
        
        shadowMask.backgroundColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25)
        
        
        shadowMask.translatesAutoresizingMaskIntoConstraints = false
        shadowMask.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        shadowMask.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        shadowMask.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        shadowMask.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
    }
    
    func configureImageView(){
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    func configureTitleLabel(){
        
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        
    }
    
}
