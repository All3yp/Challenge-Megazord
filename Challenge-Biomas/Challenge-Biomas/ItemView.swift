//
//  ItemView.swift
//  Challenge-Biomas
//
//  Created by Alley Pereira  on 6/18/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

class ItemView: UICollectionViewCell {
    
    static let identifier: String = "ItemView"
    
    let circleViewHeight: CGFloat = 25
    
    lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 7
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Legend"
//        label.backgroundColor = .systemGray
//        label.font = UIFont(name: "SF Pro Rounded", size: 32)
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.addSubview(circleView)
//            self.backgroundColor = .cyan
            self.addSubview(textLabel)
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //Setup das constraints da circleView e da textLabel
        func setupConstraints() {
            circleView.translatesAutoresizingMaskIntoConstraints = false
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                circleView.topAnchor.constraint(equalTo: self.topAnchor),
                circleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                circleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
                circleView.heightAnchor.constraint(equalToConstant: circleViewHeight),
                circleView.widthAnchor.constraint(equalToConstant: 50),
                
                textLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 10),
                textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
                textLabel.widthAnchor.constraint(equalToConstant: 125),
                textLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
                textLabel.heightAnchor.constraint(equalTo: circleView.heightAnchor)
            ])
        }
        
    }
    
